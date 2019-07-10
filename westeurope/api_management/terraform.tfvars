terragrunt = {
  # dependencies {  #   paths = [  #     "../resource_group"  #   ]  # }

  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_api_management"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Azure API Management module variables

apim_name = "01"

virtualNetworkType = "external"

vnet_name = "common"

subnet_name = "apim"

function_app_name = "1-01"

publisher_name = "Digital Citizenship"

publisher_email = "io-dev@agid.gov.it"

notification_sender_email = "io-dev@agid.gov.it"

sku_name = "Developer"

ADB2C_TENANT_ID = "cb44f084-ca44-4753-8973-dd3045d9ad2b"
