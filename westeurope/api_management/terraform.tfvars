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

virtualNetworkType = "internal"

vnet_name = "common"

subnet_name = "apim"

provisioner_version = "5"

function_app_name = "1-01"

publisher_name = "Digital Citizenship"

publisher_email = "io-dev@agid.gov.it"

notification_sender_email = "io-dev@agid.gov.it"

key_vault_id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-dev-rg/providers/Microsoft.KeyVault/vaults/io-dev-keyvault"

# sku_name = "Premium"

sku_name = "Developer"

ADB2C_TENANT_ID = "cb44f084-ca44-4753-8973-dd3045d9ad2b"
