terragrunt = {
  dependencies {
    paths = [
      "../subnet_postgresql",
      "../../key_vault"
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_postgresql_server"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Azure postgresql server module variables

azurerm_postgresql_subnet_suffix = "onboarding"
azurerm_postgresql_server_name = "onboarding"
azurerm_postgresql_server_sku_name = "GP_Gen5_2"
azurerm_postgresql_server_sku_capacity = "2"
azurerm_postgresql_server_sku_tier = "GeneralPurpose"
azurerm_postgresql_server_sku_family = "Gen5"
azurerm_postgresql_server_storage_mb = "5120"
azurerm_postgresql_server_backup_retention_days = "7"
azurerm_postgresql_server_auto_grow = "Disabled"
azurerm_postgresql_server_geo_redundant_backup = "Disabled"
azurerm_postgresql_key_vault_secret_name = "onboarding-postgresql-password"
azurerm_postgresql_version = "11"
