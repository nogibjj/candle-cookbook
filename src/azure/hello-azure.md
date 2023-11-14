# Hello, Candle on Azure.

## Prerequisites
* A [Github Account](https://github.com/join)
* An [Azure Account](https://azure.microsoft.com/en-us/free)


# Azure Spot Runner build


### Install Azure Cli 
```
$ curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

### login in to Azure 
```
$ az login 

# if above not working run:  
$ az login --use-device-code
```

```
# check your Azure account information
$ az account show

# if you have multiple accounts, you need to set the specific account you want to use: 
$ az account set --subscription <subscription_ID>
```
* the `subscription ID` is the `id` from result of az account show.
