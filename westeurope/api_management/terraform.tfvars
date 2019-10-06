terragrunt = {
  dependencies {
    paths = [
      "../subnet_apim"
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_api_management"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# APIM module variables
apim_name                 = "01"
virtualNetworkType        = "internal"
vnet_name                 = "common"
subnet_name               = "apim"
publisher_name            = "Digital Citizenship"
publisher_email           = "io-dev@agid.gov.it"
notification_sender_email = "io-dev@agid.gov.it"
sku_name                  = "Developer"
