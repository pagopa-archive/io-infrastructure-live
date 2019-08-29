## Prerequisites

The following prerequisites should be satisfied in order to use the scripts.

### Install the Azure CLI utility

The Azure CLI utility (az) is extensively used by all scripts of the repository. To install the az tool follow [this guide](https://docs.microsoft.com/it-it/cli/azure/install-azure-cli?view=azure-cli-latest).

### Log into Azure

Before being able to run the scripts you should access Azure through the CLI tool.

```shell
az login
```

A browser should open and a login form should pop up automatically.

## The scripts

This section briefly describes what the scripts do.

### .env.example and .env

The .env files contain a list of variables (a user is required to provide her/his own values) and common functions that will be used by all other scripts before execution.

### az-init.sh

The init script initializes the Azure environment, creating the following:

* An infrastructure dedicated resource group
* An infrastructure vault where to save secrets
* A storage account and a storage container for Terraform (then saving the auto-generated secret of the storage account in the infrastructure vault)
* A service profile with contributor role for Packer. The secret -saved as well in the infrastructure vault- is an auto-generated 20 chars password made of upper case and lower case letters, numbers and symbols.

The script should be completely idempotent. As such, further runs will simply keep resources as they are, if already existing in the Azure subscription.

Ideally, the script should run only once.

### az-export.sh

The export script loads some values from the .env file and the Azure Active Directory, and some secrets from the populated infrastructure vault to allow Packer and Terraform to provision the infrastructure. Values are exposed to the system as environment variables. 

The script exports the following environment variables:

* **SUBSCRIPTION**: the Azure subscription to use (comes from the .env file).

* **RG_NAME**: the infrastructure resource group where the vault is, where Terraform will save the state, and where Packer will save images (comes from the .env file). 

* **DEFAULT_ADMIN_USER**: the default admin user name created on new Packer images (comes from the .env file).

* **TERRAFORM_STORAGE_ACCOUNT_NAME**: the Terraform storage account name used to save the Terraform state (comes from the .env file).

* **TERRAFORM_CONTAINER_NAME**: the Terraform storage container name used to save the Terraform state (comes from the .env file).

* **ARM_ACCESS_KEY**: the storage access key used by Terraform to access the storage container (through the storage account) to save the state (comes from the infrastructure vault).

The script should run any time before running Packer or Terraform scripts.

## How to use the scripts

Copy the *.env.example* file to a *.env* file and customize it using your own values.

```shell
cp .env.example .env
```

**To be done just once** - to initialize the Azure account run:

```shell
source az-init.sh
```

Before using any Terraform script, export the environment variables running:

```shell
source az-export.sh
```

### API Management User, Group and subscription sync: az-apim-sync.sh

The sync script use the API Management ARM template (template.json) as source and generate 3 new ARM templates:

* Users (apim-users.json)
* Group Membership (apim-group-membership.json)
* Subscriptions (apim-subscriptions.json)

If the DRY_RUN variable has a value >0 (default) it also run the deployment on the Azure environment where you are logged in.  

NOTE: Remeber to customize script variables (on the top of the script) in order to set the desidered API Management name, product and group

## Authorize new administrators

New users should be explicitly authorized in order to list and get entries (read), both from the vault and from the Active Directory services.

This can be easily achieved through the Azure UI, as well as with scripting, even if not reported here.

### Authorize a registered user to list and read from the Vault

* Open the Azure portal
* Look for the vault name in the top search field and open it
* In the vault left panel click on IAM. Verify that 
* Click on role assignments and make sure the user is listed, at least as a *reader*
* In the vault left panel click on access policies, then *Add new*
* Do not configure from a template, but try to select the policies that best fit your needs. At the very least, the user will need to read and list the vault secrets
* Click on service principal and type the exact name of the user in the text field (otherwise no matches will be shown)
* Click ok and then save, at the top

### Authorize a registered user to list and read from the Azure Active Directory

* Open the Azure portal
* Look for Active Directory in the top search field and open it
* In the Active Directory left panel click on users and find the user you'd like to enable
* Then, always in the AD left panel click on Directory role
* Click on add role
* Give the user a role allowing to list users. For example, *Global Administrator*

>NOTE: Do this carefully, as it may impact your security!
