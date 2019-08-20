terragrunt = {
  dependencies {
    paths = [
      "../resource_group"
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_notification_hub"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Notification Hub module variables

notification_hub_name                          = "nh-01"
azurerm_notification_hub_namespace_sku_name    = "Standard"
azurerm_notification_hub_apns_application_mode = "Production" 
