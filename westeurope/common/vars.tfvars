location = "westeurope"

 environment = "dev"

  # name                = "${local.azurerm_apim_name}"
  resource_name_prefix = "io"
 
  resource_group_name  = "io-dev"
  virtualNetworkType   = "external"

  provisioner_version = "3"

  publisher_name            = "Digital Citizenship"
  publisher_email           = "apim@agid.gov.it"
  notification_sender_email = "apim@agid.gov.it"
  azurerm_function_app_name = "agid-functions-test"
  key_vault_id              = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/terraform-resource-group/providers/Microsoft.KeyVault/vaults/io-key-vault"
  sku_name                  = "Premium"
  ADB2C_TENANT_ID           = "cb44f084-ca44-4753-8973-dd3045d9ad2b"

#   eventhub_name       = "${azurerm_eventhub.azurerm_apim_eventhub.name}"