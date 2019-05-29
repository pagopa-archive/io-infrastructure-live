terragrunt = {
  dependencies {
    paths = [
      "../resource_group"
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_eventhub"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Eventhub specific variables
eventhub_name                        = "apim"
azurerm_eventhub_namespace_sku       = "Standard"
azurerm_eventhub_namespace_capacity  = 1
azurerm_eventhub_partition_count     = 2
azurerm_eventhub_messege_retention   = 7
azurerm_eventhub_authorization_rules = [
  {
    name   = "listen-send-no-manage"
    listen = true
    send   = true
    manage = false
  }
]
