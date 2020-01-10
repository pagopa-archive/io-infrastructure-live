terragrunt = {
  dependencies {
    paths = [
      "../postgresql_server"
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_postgresql_database"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Azure database module variables

azurerm_postgresql_server_name = "onboarding"
azurerm_postgresql_db_name = "onboarding"
azurerm_postgresql_db_collation = "it_IT.utf8"
