terragrunt = {
  dependencies {
    paths = [
      "../vnet_common"
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_subnet_k8s"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Azure subnet module variables
vnet_name                        = "common"
subnet_name                      = "k8s-01"
azurerm_subnet_address_prefix    = "172.16.0.0/20"
azurerm_subnet_service_endpoints = ["Microsoft.Web"]
