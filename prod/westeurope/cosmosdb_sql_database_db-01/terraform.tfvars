terragrunt = {
  dependencies {
    paths = [
      "../cosmosdb_account_01",
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_cosmosdb_sql_database"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# CosmosDB account specific variables
cosmosdb_account_name = "01"
documentdb_name       = "db-01"
