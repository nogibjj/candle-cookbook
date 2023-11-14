# Using Github Action to build Candle image on Azure Spot Runner VM

## Prerequisites
* A [Github Account](https://github.com/join)
* An [Azure Account](https://azure.microsoft.com/en-us/free)
* Finish setup [Azure Spot Runner](./azure-spot-runner.md)

## Create Github Secrets
1. In Github, go to your repository. 
2. Go to **Settings** in the navigation menu.
3. Select **Securigy > Secrets and variables > Actions**. 
4. Select **New Repository Secret**
5. Paste the entire [Json output](https://github.com/ScottLL/candle-cookbook/blob/e96d35af185ec67f382e1ac891590197705d7ffd/src/azure/hello-azure.md#L49-L50) from the Azure CLI command into the github action secret's value field. Give the secret the name: `AZURE_CREDENTIALS`. 
5. Select **Add secret.**

## Build your image
Use the [Create-Image action](./.github/workflow/create-image.yml) to create a custom virtual machine image.

```
resource-group-name: '<RESOURCE_GROUP_NAME>'
location: '<RESOURCE_LOCATION>'
managed-identity: '<AZURE-IDENTITY>'       
```
Replace the placeholders, where you created them in the Hello-azure.md, 

* [RESOURCE_GROUP_NAME](https://github.com/ScottLL/candle-cookbook/blob/e96d35af185ec67f382e1ac891590197705d7ffd/src/azure/hello-azure.md#L58)
* [RESOURCE_LOCATION](https://github.com/ScottLL/candle-cookbook/blob/e96d35af185ec67f382e1ac891590197705d7ffd/src/azure/hello-azure.md#L58)
* [AZURE-IDENTITY](https://github.com/ScottLL/candle-cookbook/blob/e96d35af185ec67f382e1ac891590197705d7ffd/src/azure/hello-azure.md#L73)

You can also change the VM type (CPU & GPU) by changing `<vm-size>`, `<source-image-type>`, `<source-image>`


## Start your Runner and Build the Binary
After you create the VM image, now we can start run it by using the [Runner Action](./.github/workflow/runner.yml). 

Note you can add your customer code inside the cloud-init.txt for specific need.

The example code in cloud-init.txt is set up to build the candle whisper binary and deploy the binary into the Github release. 

* Note, after the runner build, it might takes up to 15 mins for this cpu VM to finish the work and deploy the whisper release in Github. 

### Debugging on VM
You can check the log from Azure Portal:
1. Go to the Azure Portal.
2. Navigate to the "Virtual Machines" section.
3. Find and select the VM you created (app-vm).
4. Under the "Support + troubleshooting" section, find and click on "Serial console".
5. The serial console will open in a new window. You might have to wait for a few moments as the console establishes a connection to the VM.







