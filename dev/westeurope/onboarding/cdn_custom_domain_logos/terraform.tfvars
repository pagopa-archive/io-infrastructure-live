terragrunt = {
  dependencies {
    paths = [
      "../cdn_endpoint_frontend",
      "../../dns_zone_public_dev_io_italia_it_records",
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_cdn_custom_domain"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

azurerm_cdn_profile_suffix = "onboarding"
azurerm_cdn_endpoint_suffix = "oblogos"
azurerm_cdn_custom_domain_host_name = "logos.dev.io.italia.it"
