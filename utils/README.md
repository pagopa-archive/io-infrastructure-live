# IO utility scripts

The document describes how to use the bash utility scripts in the *utils* folder.

## Prerequisites

The following prerequisites should be satisfied in order to use the scripts.

* Python 3 - used by the Azure CLI

* [Azure CLI](https://docs.microsoft.com/it-it/cli/azure/install-azure-cli?view=azure-cli-latest)

## Authentication

Before being able to apply Terraform configurations, users need to authenticate on Azure and export some environment variables need by Terraform to operate.

To authenticate on Azure, use the Azure CLI you've downloaded, running:

```shell
az login
```

A web page will show up. When the authentication process is complete, you'll be able to go back to the Terminal.

## The .env files

Both the utlity and the Terraform scripts can work in different environments. For this reason they make use of some environment variables, that can be either defined manually or exported through a script, that reads a *.env* file.

The *utils* folder contains a *.env.example* file, that contains a description of the values to set for each variable. The *.env.example* file should be copied to a *.env* file (to keep in the same location) and filled with the values required. Values can be get from the Azure GUI (*portal.azure.com*) or from a colleague. Alternatively, a copy of a working *.env* file can be directly provided by another Administrator.

## Export the environment variables with az-export.sh

The *az-export.sh* script exports the environment variables needed by any other script. Before being able to run the script the *.env* file should have been created and properly customized.
The script exports some variable values, as they have been written in the *.env* file, some others from the Azure Active Directory, and some secrets from the infrastructure Keyvault.

Before using any other script and after the *.env* file has been sourced, to export the environment variables run:

```shell
source az-export.sh
```

## Initialize a new Azure environment with az-init.sh

>NOTE: the script should be ONLY executed if a new Azure infrastructure needs to be created from scratch. If you've been asked to work on an existing infrastructure, you should not use this script.

The *az-init.sh* script initializes a new Azure environment, creating

* A dedicated infrastructure resource group

* An infrastructure Azure Keyvault where to save secrets

* A storage account and a storage container for Terraform (saving the auto-generated secret of the storage account in the infrastructure vault)

The script should be idempotent. Further runs will simply keep resources as they are, if already existing in the Azure subscription.

After the *.env* has been created and properly customized, initialize the Azure environment, running:

```shell
source az-init.sh
```

## Sync users, groups and subscriptions using the API Management utlity scripts

The *az-apim-sync.sh* script helps operators to sync users, groups and subscriptions between two APIMs.

Data need to be first exported manually from the old APIM and saved in a local file called *template.json*. The script then takes the *template.json* file in input and generates three ARM templates:

* Users (*apim-users.json*)

* Group Membership (*apim-group-membership.json*)

* Subscriptions (*apim-subscriptions.json*)

If the *DRY_RUN* variable in the script has a value *>0* (default) it also runs the deployment on the destination Azure environment.

>**NOTE:** Remember to customize the variables at the top of the script to set the source and destination name, product and resource groups of the Azure API Management Services (APIMs).

To synchronize users run:

```shell
source az-apim-sync.sh
```

## Check for circular dependencies in live modules

This will be used primarily in the CI process. Two main possible usage are either as_text or as_image.

as_text is meant to be use by a CI process as an exit code is raised depending if it discovered (simple) `circular dependencies` or in general issue with dependencies.

as_image if the user wants an image to represent the terragrunt dependencies.

### Usage

* Create a python virtual environment -> `virtualenv venv`

* Enable the environment -> `source venv/bin/activate`

* Install required libries -> `source venv/bin/activate`

* Run the script -> `python check_live_circular_dependencies.py -o live -d ../dev/westeurope`

## Copy secrets between two Azure keyvaults

The *secrets-copier.sh* scripts allows to copy a pre-defined list of secrets between two keyvaults of the same subscription.

To start the copy, simply make sure the name of the source and the destination vaults are up to date, and that the list of secrets reflects the ones you have to copy. Then execute it running `bash secrets-copier.sh` or `./secrets-copier.sh`.
