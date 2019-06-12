terragrunt = {
  dependencies {
    paths = [
      "../storage_account_appdata",
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_storage_container"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Storage container module related variables
azurerm_storage_account_name_suffix = "appdata"

azurerm_storage_container_name = "message-content"
