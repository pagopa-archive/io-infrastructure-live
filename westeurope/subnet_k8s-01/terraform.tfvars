terragrunt = {
  dependencies {
    paths = [
      "../vnet_common"
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_subnet"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Azure subnet module variables
vnet_name                     = "common"
subnet_name                   = "k8s-01"
azurerm_subnet_address_prefix = "172.16.0.0/20"
add_security_group             = false
azurerm_network_security_rules = []
