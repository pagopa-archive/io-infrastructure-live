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
vnet_name                        = "common"
subnet_name                      = "function-app"
azurerm_subnet_address_prefix    = "172.16.53.0/24"
azurerm_subnet_service_endpoints = ["Microsoft.Storage","Microsoft.AzureCosmosDB","Microsoft.Web"]
add_security_group               = true
azurerm_network_security_rules   = []
set_subnet_delegation            = true
azurerm_subnet_delegation_name   = "Microsoft.Web/serverFarms"
