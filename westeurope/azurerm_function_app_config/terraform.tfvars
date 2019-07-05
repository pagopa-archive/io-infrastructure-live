# Creates a Kubernetes Cluster through AKS using the Kubenet CNI.
# For more info look at the README.md file of the module.

terragrunt = {
  dependencies {
    paths = [
      "../azurerm_function_app",
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

# Function App module variables
# log_analytics_workspace_name = "log-analytics-workspace"

vnet_name = "common"

subnet_name = "functions"

plan_name = "premium-plan"


azurerm_functionapp_git_repo = "https://github.com/teamdigitale/digital-citizenship-functions"

azurerm_functionapp_git_branch = "funcpack-release-latest"

azurerm_key_vault_tenant_id = "cb44f084-ca44-4753-8973-dd3045d9ad2b"
