terragrunt = {
  dependencies {
    paths = [
      "../resource_group"
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
dns_zone_suffix            = "io.italia.it"
azurerm_dns_zone_zone_type = "Public"
dns_reverse_zone           = false
add_environment            = true
