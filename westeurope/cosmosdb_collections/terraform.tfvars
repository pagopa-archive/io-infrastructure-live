terragrunt = {
  dependencies {
    paths = [
      "../resource_group"
    ]
  }

  terraform {
    source = "git = =git@github.com =teamdigitale/io-infrastructure-modules.git//azurerm_cosmosdb_collections"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# CosmosDB account specific variables
cosmosdb_account_name                        = "apim"

azurerm_cosmosdb_collections = {
    messages = "fiscalCode"
    profiles = "fiscalCode"
    notifications = "messageId"
    notification-status = "notificationId"
    message-status = "messageId"
    services = "serviceId"
    sender-services = "recipientFiscalCode"
  }