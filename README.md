# IO (Digital Citizenship) infrastructure Terraform modules

The repository contains the Terraform modules used to provision and maintain the IO infrastructure. This should be considered a library of modules to be called from the [Terraform live infrastructure repository](https://github.com/teamdigitale/io-infrastructure-live).

## What is IO?

More informations about the IO can be found on the [Digital Transformation Team website](https://teamdigitale.governo.it/en/projects/digital-citizenship.htm)

## Tools references

The tools used in this repository are

* [Terragrunt](https://github.com/gruntwork-io/terragrunt)
* [Terraform](https://www.terraform.io/)

## Environments and branching structure

Code is versioned, depending on the environment it will run into. Branches represent different deployment environments. You may find in this repository a [development](https://github.com/teamdigitale/io-infrastructure-live/tree/development), a staging and a [master](https://github.com/teamdigitale/io-infrastructure-live) branch (the last one representing the production environment).

## Repository directories and files structure

```
Deployment area
    |_ Module
```

The root folder contains one or more *deployment areas*, for example *westeurope*.

Each deployment area contains one or more live scripts that have a one to many correspondence with Terraform modules. Terraform modules are maintained in a [separate repository](https://github.com/teamdigitale/io-infrastructure-modules).

Modules' variables and main Terragrunt configuration files are stored in *terraform.tfvars* files.
Modules can also optionally inherit shared variables from higher level folders. These variables may be stored at each level of the hierarchy in the *vars.tfvars* files. For example, the *westeurope* folder under each environment contain the variable `location = "westeurope"`, that is inherited from all the underlying modules.

## How to use the scripts

First, export the environment variables needed by Terraform to work. Source the *az-export.sh* utility script in the *utility* folder. More info can be found in the readme in the *utility* folder.

Then, you can start to provision the infrastructure.

To provision a specific component go in the component folder and run

```shell
terragrunt apply
```

If you have not committed your Terragrunt modules yet, and you'd like to test the scripts using local modules run:

```
terragrunt apply --terragrunt-source PATH_TO_YOUR_THE_LOCAL_MODULE_DIR
```

>Note: Substitute apply with destroy to destroy an entire environment

Sometimes you may want to provision the entire environment. To do so, go into the environment folder (for example *westeurope*) and run

```shell
terragrunt apply-all
```

Terragrunt will try to apply all the components in the westeurope folder, understanding what should be apply first and what should be applied later, depending on the dependencies defined in the components' terraform.tfvars files.

>Note: Substitute apply-all with destroy-all to destroy an entire environment

## How to contribute

Contributions are welcome. Feel free to open issues and submit a pull request at any time!
