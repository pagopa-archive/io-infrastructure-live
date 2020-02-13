terragrunt = {
  dependencies {
    paths = [
      "../storage_account_assets",
      "../cdn_profile-01"
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_cdn_sa_endpoint"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

azurerm_cdn_endpoint_profile_suffix = "01"
azurerm_cdn_endpoint_name = "assets"
origin_storage_account_suffix = "assets"
