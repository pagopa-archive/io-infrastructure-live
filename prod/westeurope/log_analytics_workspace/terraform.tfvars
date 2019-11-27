# Creates a Kubernetes Cluster through AKS using the Kubenet CNI.
# For more info look at the README.md file of the module.

terragrunt = {
  dependencies {
    paths = [
      "../resource_group"
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_log_analytics_workspace"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Log workspace analytics module variables
log_analytics_workspace_name                      = "log-analytics-workspace"
azurerm_log_analytics_workspace_retention_in_days = 180
