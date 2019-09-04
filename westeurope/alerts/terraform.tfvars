# For more info look at the README.md file of the module.

terragrunt = {
  dependencies {
    paths = [
      "../monitoring"
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_monitor_metric_alert"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Monitoring metric alerts variables
azurerm_monitor_action_group_name_suffix               = "01"
azurerm_monitor_metric_alert_name                      = "io-dev-aks-k8s-01 less then 5 cpu available"
azurerm_monitor_metric_alert_description               = "Check io-dev-aks-k8s-01 cpu availability"
azurerm_monitor_metric_alert_scopes                    = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-dev-rg/providers/Microsoft.ContainerService/managedClusters/io-dev-aks-k8s-01"
azurerm_monitor_metric_alert_criteria_metric_name      = "kube_node_status_allocatable_cpu_cores"
azurerm_monitor_metric_alert_criteria_metric_namespace = "Microsoft.ContainerService/managedClusters"
azurerm_monitor_metric_alert_criteria_aggregation      = "Total"
azurerm_monitor_metric_alert_criteria_operator         = "LessThanOrEqual"
azurerm_monitor_metric_alert_criteria_treshold         = "5.0"
