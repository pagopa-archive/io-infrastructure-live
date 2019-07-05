#!/usr/bin/env bash

# Script to ease secret uploading to keyvault loaded by the function app module
# Each secret "name" parameter should match its own "Alias" declared within the  terraform.tfvar file for the function module
# Replace "xxxxxxxxx" with the secret value (do not commit the resulting file)

VAULT_NAME="io-dev-keyvault"

az keyvault secret set --vault-name "$VAULT_NAME" --name "cosmosdb-key" --value "xxxxxxxxx"

az keyvault secret set --vault-name "$VAULT_NAME" --name "cosmosdb-uri" --value "xxxxxxxxx"

az keyvault secret set --vault-name "$VAULT_NAME" --name "azurewebjobssecretstoragetype" --value "disabled"

az keyvault secret set --vault-name "$VAULT_NAME" --name "azurewebjobsstorage" --value "xxxxxxxxx"

az keyvault secret set --vault-name "$VAULT_NAME" --name "diagnostics-azureblobretentionindays" --value "1"

az keyvault secret set --vault-name "$VAULT_NAME" --name "appinsights-instrumentationkey" --value "xxxxxxxxx"

az keyvault secret set --vault-name "$VAULT_NAME" --name "mail-from-default" --value "xxxxxxxxx"

az keyvault secret set --vault-name "$VAULT_NAME" --name "mailup-secret" --value "xxxxxxxxx"

az keyvault secret set --vault-name "$VAULT_NAME" --name "mailup-username" --value "xxxxxxxxx"

az keyvault secret set --vault-name "$VAULT_NAME" --name "message-container-name" --value "message-content"

az keyvault secret set --vault-name "$VAULT_NAME" --name "public-api-key" --value "xxxxxxxxx"

az keyvault secret set --vault-name "$VAULT_NAME" --name "public-api-url" --value "xxxxxxxxx"

az keyvault secret set --vault-name "$VAULT_NAME" --name "cosmosdb-name" --value "xxxxxxxxx"

az keyvault secret set --vault-name "$VAULT_NAME" --name "queuestorageconnection" --value "xxxxxxxxx"

az keyvault secret set --vault-name "$VAULT_NAME" --name "webhook-channel-url" --value "xxxxxxxxx"

az keyvault secret set --vault-name "$VAULT_NAME" --name "website-httplogging-retention-days" --value "3"

az keyvault secret set --vault-name "$VAULT_NAME" --name "function-app-edit-mode" --value "readonly"

az keyvault secret set --vault-name "$VAULT_NAME" --name "scm-use-funcpack-build" --value "1"

az keyvault secret set --vault-name "$VAULT_NAME" --name "functions-extension-version" --value "~1"

az keyvault secret set --vault-name "$VAULT_NAME" --name "functions-worker-runtime" --value "node"

az keyvault secret set --vault-name "$VAULT_NAME" --name "website-node-default-version" --value "6.11.2"
