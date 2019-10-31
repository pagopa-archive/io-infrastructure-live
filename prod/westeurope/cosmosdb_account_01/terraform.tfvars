terragrunt = {
  dependencies {
    paths = [
      "../key_vault",
      "../subnet_function_app_admin",
      "../subnet_function_app_app",
      "../subnet_function_app_services"
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
cosmosdb_account_name                                      = "01"
azurerm_cosmosdb_account_offer_type                        = "Standard"
azurerm_cosmosdb_account_kind                              = "GlobalDocumentDB"

azurerm_cosmosdb_account_consistency_policy                = {
  consistency_level = "Session"
}

# Firewall settings
allowed_vnet_suffix                                        = "common"
allowed_subnets_suffix                                     = [
  "function-app",
  "function-services",
  "function-admin"
]
