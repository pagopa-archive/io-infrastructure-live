terragrunt = {
  dependencies {
    paths = [
      "../storage_account_appdata"
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_storage_table"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Storage account module related variables
storage_account_name_suffix = "appdata"
azurerm_storage_table_name  = "SubscriptionsFeedByDay"
