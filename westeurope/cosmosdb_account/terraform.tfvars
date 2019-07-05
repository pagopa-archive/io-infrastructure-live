terragrunt = {
  dependencies {
    paths = [
      "../resource_group",
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_cosmosdb_account"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# CosmosDB account specific variables
cosmosdb_account_name                                      = "apim"
azurerm_cosmosdb_account_offer_type                        = "Standard"
azurerm_cosmosdb_account_kind                              = "GlobalDocumentDB"

azurerm_cosmosdb_account_consistency_policy                = {
  consistency_level                                        = "Session"
}

# TODO: extract environment variables (dev / prod)
azurerm_cosmosdb_account_geo_location_master = {
  location                                                 = "westeurope"
  failover_priority                                        = 0
  prefix                                                   = "io-dev-cosmosdb-apim-master"
}

azurerm_cosmosdb_account_geo_location_slave = {
  location                                                 = "northeurope"
  failover_priority                                        = 1
  prefix                                                   = "io-dev-cosmosdb-apim-slave"
}

azurerm_cosmosdb_account_is_virtual_network_filter_enabled = true

# TODO: create arbitrary number of virtual_network_rule with terraform 0.12
vnet_name                                                  = "common"
subnet_name                                                = "functions"
