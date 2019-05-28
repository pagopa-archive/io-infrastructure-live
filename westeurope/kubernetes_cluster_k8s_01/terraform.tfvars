# Creates a Kubernetes Cluster through AKS using the Kubenet CNI.
# For more info look at the README.md file of the module.

terragrunt = {
  dependencies {
    paths = [
      "../subnet_k8s_01",
      "../dns_zone_private_common",
      "../service_principal_k8s_01",
      "../log_analytics_workspace"
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_aks_cluster"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# AKS module variables
log_analytics_workspace_name                                  = "log-analytics-workspace"
aks_cluster_name                                              = "k8s-01"
azurerm_kubernetes_cluster_linux_profile_admin_username       = "teamdigitale"
azurerm_kubernetes_cluster_agent_pool_profile_count           = 1
azurerm_kubernetes_cluster_agent_pool_profile_vm_size         = "Standard_DS2_v2"
azurerm_kubernetes_cluster_agent_pool_profile_max_pods        = 100
azurerm_kubernetes_cluster_network_profile_pod_cidr           = "172.16.32.0/20"
azurerm_kubernetes_cluster_network_profile_service_cidr       = "172.16.16.0/20"
azurerm_kubernetes_cluster_network_profile_dns_service_ip     = "172.16.16.10"
azurerm_kubernetes_cluster_network_profile_docker_bridge_cidr = "172.17.0.1/16"
azurerm_kubernetes_cluster_kubernetes_version                 = "1.13.5"
azurerm_key_vault_secret_name                                 = "k8s01spsecret"
vnet_name                                                     = "common"
subnet_name                                                   = "k8s-01"