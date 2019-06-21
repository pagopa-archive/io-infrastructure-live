# Creates a Kubernetes Cluster through AKS using the Kubenet CNI.
# For more info look at the README.md file of the module.

terragrunt = {
  dependencies {
    paths = [
      "../subnet_k8s_01",
      "../cosmosdb_sql_database",
      "../subnet_functions",
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_function_app"
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

storage_account_name = "functions"

# azurerm_functionapp_git_repo = "test"


# azurerm_functionapp_git_branch = "test"


# key_vault_id =""

