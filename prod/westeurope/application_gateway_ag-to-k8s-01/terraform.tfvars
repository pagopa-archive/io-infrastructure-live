terragrunt = {
  dependencies {
    paths = [
      "../kubernetes_cluster_k8s-01",
      "../subnet_ag-to-k8s-01",
      "../public_ip_ag-to-k8s-01"
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_application_gateway_plain"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Application gateway variables
application_gateway_name_suffix                               = "to-k8s-01"
public_ip_address_name_suffix                                 = "ag-to-k8s-01"
subnet_name_suffix                                            = "ag-to-k8s-01"
vnet_name_suffix                                              = "common"
