terragrunt = {
  dependencies {
    paths = [
      "../vnet_common"
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_dns_zone"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Azure DNS zone module variables
dns_zone_prefix            = "common"
dns_zone_suffix            = "io.internal"
azurerm_dns_zone_zone_type = "Private"
registration_vnets         = ["common"]
resolution_vnets           = []
