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
publisher_name            = "IO Italia"
publisher_email           = "io-apim@teamdigitale.governo.it"
notification_sender_email = "io-apim@teamdigitale.governo.it"
sku_name                  = "Developer"
