# Set up CNAME for static websites (azure storage through CDN endpoints)

terragrunt = {
  dependencies {
    paths = [
      "../../dns_zone_public_dev_io_italia_it",
      "../cdn_endpoint_logos",
      "../cdn_endpoint_frontend",
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_dns_zone_records_dev_io_italia_it"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Azure DNS zone records module variables

dns_zone_suffix = "dev.io.italia.it"

onboarding_cname_records = [
  "onboarding",
  "logos"
]
