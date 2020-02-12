terragrunt = {
  dependencies {
    paths = [
      "../subnet_function_app_app",
      "../subnet_function_app_admin",
      "../subnet_function_app_services"
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_storage_account"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Storage account module related variables
storage_account_name                              = "appdata"
azurerm_storage_account_account_tier              = "Standard"
azurerm_storage_account_account_replication_type  = "LRS"
allowed_subnets_suffixes                          = [
  "function-admin",
  "function-app",
  "function-services",
  "function-public"
]
azurerm_storage_account_network_rules_allowed_ips = []
create_keyvault_secret                            = true
