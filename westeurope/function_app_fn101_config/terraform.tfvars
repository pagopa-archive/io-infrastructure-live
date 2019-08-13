# Creates a Kubernetes Cluster through AKS using the Kubenet CNI.
# For more info look at the README.md file of the module.

terragrunt = {
  dependencies {
    paths = [
      "../function_app_fn101"
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
functionapp_name                          = "1-01"
vnet_name                                 = "common"
subnet_name                               = "functions"
azurerm_functionapp_git_repo              = "https://github.com/teamdigitale/digital-citizenship-functions"
azurerm_functionapp_git_branch            = "funcpack-release-latest"
storage_account_name                      = "fn101"
azurerm_functionapp_reservedInstanceCount = "1"
