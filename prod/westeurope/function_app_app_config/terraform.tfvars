# Creates a Kubernetes Cluster through AKS using the Kubenet CNI.
# For more info look at the README.md file of the module.

terragrunt = {
  dependencies {
    paths = [
      "../function_app_app"
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_function_app_config"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Function app config module variables
functionapp_name                          = "2-app"
vnet_name                                 = "common"
subnet_name                               = "function-app"
storage_account_name                      = "fn2app"
azurerm_functionapp_reservedInstanceCount = "1"
