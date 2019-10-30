terragrunt = {
  dependencies {
    paths = [
      "../cosmosdb_sql_database_db-01"
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_cosmosdb_container"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# CosmosDB account specific variables
cosmosdb_account_name = "01"
documentdb_name       = "db-01"
container_name        = "sender-services"
container_throughput  = 1000
partitionKey_paths    = ["/recipientFiscalCode"]
includedPaths         = [{
  path    = "/*"
  indexes = [
    {
      kind      = "Range"
      dataType  = "number"
      precision = -1
    },
    {
      kind      = "Range"
      dataType  = "string"
      precision = -1
    },
    {
      kind     = "Spatial"
      dataType = "Point"
    },
  ]
}]
