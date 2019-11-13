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
azurerm_monitor_action_group_name_suffix = "01"

alerts = [
  {
    azurerm_monitor_action_group_name_suffix               = "01"
    azurerm_monitor_metric_alert_name                      = "io-prod-aks-k8s-01 less then 5 cpu available"
    azurerm_monitor_metric_alert_description               = "Critical: Check io-prod-aks-k8s-01 cpu availability (5 or less)"
    azurerm_monitor_metric_alert_scopes                    = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-prod-rg/providers/Microsoft.ContainerService/managedClusters/io-prod-aks-k8s-01"
    azurerm_monitor_metric_alert_criteria_aggregation      = "Total"
    azurerm_monitor_metric_alert_criteria_metric_name      = "kube_node_status_allocatable_cpu_cores"
    azurerm_monitor_metric_alert_criteria_metric_namespace = "Microsoft.ContainerService/managedClusters"
    azurerm_monitor_metric_alert_criteria_operator         = "LessThanOrEqual"
    azurerm_monitor_metric_alert_criteria_treshold         = "5.0"
  },
  {
    azurerm_monitor_action_group_name_suffix               = "01"
    azurerm_monitor_metric_alert_name                      = "io-prod-aks-k8s-01 less then 10 cpu available"
    azurerm_monitor_metric_alert_description               = "Warning: Check io-prod-aks-k8s-01 cpu availability (10 or less)"
    azurerm_monitor_metric_alert_scopes                    = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-prod-rg/providers/Microsoft.ContainerService/managedClusters/io-prod-aks-k8s-01"
    azurerm_monitor_metric_alert_criteria_aggregation      = "Total"
    azurerm_monitor_metric_alert_criteria_metric_name      = "kube_node_status_allocatable_cpu_cores"
    azurerm_monitor_metric_alert_criteria_metric_namespace = "Microsoft.ContainerService/managedClusters"
    azurerm_monitor_metric_alert_criteria_operator         = "LessThanOrEqual"
    azurerm_monitor_metric_alert_criteria_treshold         = "10.0"
  },
  {
    azurerm_monitor_action_group_name_suffix               = "01"
    azurerm_monitor_metric_alert_name                      = "io-prod-aks-k8s-01 less then 15Gb memory available"
    azurerm_monitor_metric_alert_description               = "Warning: Check io-prod-aks-k8s-01 cpu availability (15 or less)"
    azurerm_monitor_metric_alert_scopes                    = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-prod-rg/providers/Microsoft.ContainerService/managedClusters/io-prod-aks-k8s-01"
    azurerm_monitor_metric_alert_criteria_aggregation      = "Total"
    azurerm_monitor_metric_alert_criteria_metric_name      = "kube_node_status_allocatable_memory_bytes"
    azurerm_monitor_metric_alert_criteria_metric_namespace = "Microsoft.ContainerService/managedClusters"
    azurerm_monitor_metric_alert_criteria_operator         = "LessThanOrEqual"
    azurerm_monitor_metric_alert_criteria_treshold         = "16106127360"
  },
  {
    azurerm_monitor_action_group_name_suffix               = "01"
    azurerm_monitor_metric_alert_name                      = "io-prod-aks-k8s-01 less then 5Gb moemory available"
    azurerm_monitor_metric_alert_description               = "Warning: Check io-prod-aks-k8s-01 Memory Availability (5Gb or less)"
    azurerm_monitor_metric_alert_scopes                    = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-prod-rg/providers/Microsoft.ContainerService/managedClusters/io-prod-aks-k8s-01"
    azurerm_monitor_metric_alert_criteria_aggregation      = "Total"
    azurerm_monitor_metric_alert_criteria_metric_name      = "kube_node_status_allocatable_memory_bytes"
    azurerm_monitor_metric_alert_criteria_metric_namespace = "Microsoft.ContainerService/managedClusters"
    azurerm_monitor_metric_alert_criteria_operator         = "LessThanOrEqual"
    azurerm_monitor_metric_alert_criteria_treshold         = "5368709120"
  }
]
