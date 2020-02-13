terragrunt = {
  dependencies {
    paths = []
  }

  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_cdn_profile"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

azurerm_cdn_profile_suffix = "01"
