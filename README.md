# IO (Digital Citizenship) infrastructure Terraform modules

The repository contains the Terraform modules used to provision and maintain the IO infrastructure. This should be considered a library of modules to be called from the [Terraform live infrastructure repository](https://github.com/teamdigitale/io-infrastructure-live).

## What is IO?

More informations about the IO can be found on the [Digital Transformation Team website](https://teamdigitale.governo.it/en/projects/digital-citizenship.htm)

## Repository directories and files structure

```
Environment
    |_Deployment area
        |_ Module
```

The root folder contains one or more *environments*, for example *dev* or *prod*. There's an extra service environment called *infra*: the corresponding resource group contains the *io.italia.it* DNS zone and related records and the resources used by Terraform itself to work.

Each *environment* contains one or more *deployment areas*, for example *westeurope*.

Each deployment area contains one or more live scripts that have a one to one correspondence with a Terraform module. The Terraform modules are maintained in a [separate repository](https://github.com/teamdigitale/pdnd-infra-tf-modules).

Module variables and main Terragrunt configuration files are stored in *terraform.tfvars* files.
Modules can also optionally inherit shared variables from higher level folders. These variables may be stored at each level of the hierarchy in the *vars.tfvars* files. For example, the *westeurope* folder under each environment contains the variable `location = "westeurope"`, that is inherited by all the underlying modules.

## Prerequisites

The following softwares need to be installed on your machine before moving forward.

* Python 3 - used by the Azure CLI

* [Azure CLI](https://docs.microsoft.com/it-it/cli/azure/install-azure-cli?view=azure-cli-latest)

* [Terraform v0.11.14](https://www.terraform.io/)

* [Terragrunt v0.18.2](https://github.com/gruntwork-io/terragrunt)

>NOTE: it's strongly suggested to install both the tools manually copying their binary in the local path.

>NOTE: Terraform 0.12 is still not supported.

Additional requirements:

* Ask to another Administrator to invite you on the Azure subscription you've to run the scripts aginst, and to assign you a *Contributor role*.

* Ask to another Administrator to set (at least) a *Reader access policy* on the Keyvauly *io-infra-keyvault* in the resource group *io-infra-rg*

## Authentication and environment variables export

Before being able to apply Terraform configurations, users need to authenticate on Azure and export some environment variables need by Terraform to operate.

To authenticate on Azure, use the Azure CLI you've downloaded, running:

```shell
az login
```

A web page will show up. When the authentication process is complete, you'll be able to go back to the Terminal.

Copy the *.env.example* file located in the *utils* directory to a *.env* file (keep it in the same location) and fill in the values required. You can get these values from the Azure GUI (*portal.azure.com*) or from a colleague. Alternatively, you can directly ask to another Administrator for a copy of a final *.env* file.

Finally, source the *az-export.sh* script in the *utils* folder (while you are in the utils folder):

```shell
source az-export.sh
```

You can now apply the Terraform files.

More info about the *utils scripts* can be found in the [README](utils/README.md) of the *utils* folder.

## How to plan and apply the Terraform configurations

Each component applied along the hierarchy will also inherit the variable values (if used by the component) from the top *vars.tfvars* and *terraform.tfvars* files.

To provision a specific component go in the component folder and run

```shell
terragrunt apply
```

If you have not committed your Terragrunt modules yet, and you'd like to test the scripts using local modules run:

```shell
terragrunt apply --terragrunt-source PATH_TO_YOUR_THE_LOCAL_MODULE_DIR
```

>HINT: Substitute apply with plan or destroy to plan or destroy a component.

Sometimes, you may want to provision the entire environment. To do so, go into the environment folder (for example *dev* or *dev/westeurope*) and run

```shell
terragrunt apply-all
```

Terragrunt will try to apply all the components under the folder where the Terragrunt command is applied, understanding what module should be applied first and what should be applied later, depending on the dependencies defined in the components' *terraform.tfvars* files.

>NOTE: Substitute apply-all with plan-all or destroy-all to destroy an entire environment.

## How to contribute

Contributions are welcome. Feel free to open issues and submit a pull request at any time!
