# Azure spot runner with Github Action.
Using Ephemeral Infrastructure with Azure VMS as GitHub Action Runners to build Candle binary latter.

## Requirements 
* Setup [Azure Account](../hello-azure.md) and record the `subscription ID` you have from the setting. 

* Create a [Personal Access Token (PAT)](https://github.com/settings/tokens/new?description=Azure+GitHub+Runner&scopes=repo) record as `$GitHubPAT`


### Create an service principle with the following details:
* AppID 
* password 
* tenant information 

#### Create an service principal by running: 
```
$ az ad sp create-for-rbac -n "Name_of_Service_principal"
```
* This output contains all the infomation about your `AZURE_CREDENTIALS`. Please copy & save it to your local in order to set up VM after we setup the Spot Runner.  

The output includes credentials that you must protect. Be sure that you do not include these credentials in your code or check the credentials into your source control. For more information, see https://aka.ms/azadsp-cli

### Create an Azure Resource Group

A resource group is a way to group services together so that you can keep track of them and delete them later with ease. Use the `az` CLI to accomplish this:
```
az group create --location eastus --name "<RESOURCE_GROUP_NAME>"
```

Keep that resource group name handy for other operations. In this repository the `$<RESOURCE_GROUP_NAME>` resource group is used throughout. Note the location as well. Make sure that the location (region) maps to the resources you want to create.



### Create an Azure Key Vault
You will store your GitHub PAT here so that it can later be retrieved by the VM.
```
$ az keyvault create --name candel-vms --resource-group githubVM --location eastus
$ az keyvault secret set --vault-name candel-vms --name "GitHubPAT" --value $GITHUB_PAT
```
Replace $GITHUB_PAT with the value of the PAT created earlier

### Assign an identity with permissions for Key Vault
Now that the key vault is created, you need to create an identity and then allow resources in the resource group to be able to access it. You must give this identity a name, in this case we use GitHubVMs. Note this name will be used in other steps.

```
$ az identity create --name GitHubVMs --resource-group githubVM --location eastus

```
Capture the Principal ID which will be used for the value for --object-id later. You can retrieve it again by using:

```
$ az identity show --name GitHubVMs --resource-group githubVM
```

Use the object id to set the policy, replace $OBJECT_ID with the one you found in the previous command:
```
$ az keyvault set-policy --name candel-vms --object-id <$BOJECT_ID> --secret-permissions get
```

### Verify you can get the PAT with the following command:
```
az keyvault secret show --name "GitHubPAT" --vault-name candel-vms --query value -o tsv
```


### Provide a role to VMs
Assign a role to the VMs so that they have enough permissions to write the image when getting created. Start by finding the principalId which will then be needed for the next step:

```
az identity show --name GitHubVMs --resource-group githubVM --query principalId
```

With the principalId you can assign it to the VMs now:

```
az role assignment create --assignee <principal_ID> --role Contributor --resource-group githubVM
```


### Trigger the create image run
Now you are ready to create the image. Run it manually and make sure it works correctly. If succesful, an image will be created for you which you can query with the following command:
```
az image list --resource-group githubVM --output table
```


