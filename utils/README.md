# IO utility scripts

The document describes how to use the bash utility scripts in this folder.

## Prerequisites

The following prerequisites should be satisfied in order to use the scripts.

* **Install the Azure CLI utility**: the Azure CLI utility (az) is extensively used by all scripts of the repository. To install the az tool follow [this guide](https://docs.microsoft.com/it-it/cli/azure/install-azure-cli?view=azure-cli-latest).

* **Log into Azure**: Before being able to run the scripts you should access Azure through the CLI tool.

```shell
az login
```

A browser should open and a login form should pop up automatically.

## Initialize the Azure environment and export envrionment variables

A combination of three scripts (*.env.example*, *az-init.sh*, *az-export.sh*) allows operators to make a generic Azure subscription ready to work with Terraform, and export the environment variables needed by other scripts (i.e. Terraform) to work.

### Define your environment settings with the .env files

The .env files contain a list of variables and common functions that are read by all other scripts, before execution.

Before running any other script, copy the *.env.example* file to a *.env* file and customize it using your own values.

```shell
cp .env.example .env
```

### Initialize the Azure infrastructure with az-init.sh

The *az-init.sh* script initializes the Azure environment, creating

* A dedicated infrastructure resource group

* An infrastructure Azure Keyvault where to save secrets

* A storage account and a storage container for Terraform (then saving the auto-generated secret of the storage account in the infrastructure vault)

The script should be idempotent. Further runs will simply keep resources as they are, if already existing in the Azure subscription.

After the *.env* file has been sourced, initialize the Azure account running:

```shell
source az-init.sh
```

### Export the environment variables with az-export.sh

The *az-export.sh* script loads some values from the .env file, from the Azure Active Directory, and some secrets from the infrastructure Keyvault to allow Terraform to provision the infrastructure. Values are exposed to the system as environment variables.

Before using any other script and after the *.env* file has been sourced, to export the environment variables run:

```shell
source az-export.sh
```

## API Management utlity scripts: sync users, groups and subscriptions

The *az-apim-sync.sh* helps operators to sync users, groups and subscriptions between two APIMs.
Data should be exported manually from the old APIM and saved in a local file called *template.json*. The script takes the (*template.json*) file in input and generates three ARM templates:

* Users (*apim-users.json*)

* Group Membership (*apim-group-membership.json*)

* Subscriptions (*apim-subscriptions.json*)

If the *DRY_RUN* variable has a value *>0* (default) it also runs the deployment on the destination Azure environment.

>**NOTE:** Remeber to customize script variables -at the top of the script- to set the source and destination Azure API Management Services (APIMs) name, product and resource group.

To synchronize users run:

```shell
source az-apim-sync.sh
```
