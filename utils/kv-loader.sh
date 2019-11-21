#!/usr/bin/env bash

# Script to ease secret uploading to keyvault loaded by the function app module
# Each secret "name" parameter should match its own "Alias" declared within the  terraform.tfvar file for the function module
# Replace "xxxxxxxxx" with the secret value (do not commit the resulting file) and set VAULT_NAME with the right value es.: io-dev-keyvault

VAULT_NAME="io-prod-keyvault"

# APIM
az keyvault secret set --vault-name "$VAULT_NAME" --name "app-insight-web-tests-Ocp-Apim-Subscription-Key" --value "VALUE"
az keyvault secret set --vault-name "$VAULT_NAME" --name "application-gateway-to-apim-01-cert" --value "VALUE"
az keyvault secret set --vault-name "$VAULT_NAME" --name "developerPortalSpSecret" --value "VALUE"

# FUNCTION 
az keyvault secret set --vault-name "$VAULT_NAME" --name "fn2adminadminCode" --value "VALUE"
az keyvault secret set --vault-name "$VAULT_NAME" --name "fn2adminAppInsightsInstrumentationKey" --value "VALUE"
az keyvault secret set --vault-name "$VAULT_NAME" --name "fn2adminStorageConnection" --value "VALUE"
az keyvault secret set --vault-name "$VAULT_NAME" --name "fn2appAppInsightsInstrumentationKey" --value "VALUE"
az keyvault secret set --vault-name "$VAULT_NAME" --name "fn2CommonsMailupSecret" --value "VALUE"
az keyvault secret set --vault-name "$VAULT_NAME" --name "fn2CommonsMailupUsername" --value "VALUE"
az keyvault secret set --vault-name "$VAULT_NAME" --name "fn2servicesAppInsightsInstrumentationKey" --value "VALUE"
az keyvault secret set --vault-name "$VAULT_NAME" --name "fn2servicesFunctionAppHostKey" --value "VALUE"
az keyvault secret set --vault-name "$VAULT_NAME" --name "fn2servicesMailupSecret" --value "VALUE"
az keyvault secret set --vault-name "$VAULT_NAME" --name "fn2servicesMailupUsername" --value "VALUE"
az keyvault secret set --vault-name "$VAULT_NAME" --name "fn2servicesQueueStorageConnection" --value "VALUE"
az keyvault secret set --vault-name "$VAULT_NAME" --name "fn2servicesWebhookChannelUrl" --value "VALUE"

# APPLICATION GATEWAY
az keyvault secret set --vault-name "$VAULT_NAME" --name "generated-cert" --value "VALUE"

# KUBERNETES
az keyvault secret set --vault-name "$VAULT_NAME" --name "k8s-app-backend-secrets" --value "VALUE"
az keyvault secret set --vault-name "$VAULT_NAME" --name "k8s-app-backend-secrets-spid-certs" --value "VALUE"
az keyvault secret set --vault-name "$VAULT_NAME" --name "k8s-developer-portal-backend-secrets" --value "VALUE"
az keyvault secret set --vault-name "$VAULT_NAME" --name "k8s-pagopa-proxy-prod-secrets" --value "VALUE"
az keyvault secret set --vault-name "$VAULT_NAME" --name "k8s-pagopa-proxy-test-secrets" --value "VALUE"
az keyvault secret set --vault-name "$VAULT_NAME" --name "k8s-pagopa-proxy-test-secrets-io-certs" --value "VALUE"
az keyvault secret set --vault-name "$VAULT_NAME" --name "k8s-pagopa-proxy-test-secrets-pagopa-ca-chain-certs" --value "VALUE"

# NOTIFICATION HUB
az keyvault secret set --vault-name "$VAULT_NAME" --name "nhub01bundleid" --value "VALUE"
az keyvault secret set --vault-name "$VAULT_NAME" --name "nhub01gcmkey" --value "VALUE"
az keyvault secret set --vault-name "$VAULT_NAME" --name "nhub01keyid" --value "VALUE"
az keyvault secret set --vault-name "$VAULT_NAME" --name "nhub01teamid" --value "VALUE"
az keyvault secret set --vault-name "$VAULT_NAME" --name "nhub01token" --value "VALUE"

# TERRAFORM
az keyvault secret set --vault-name "$VAULT_NAME" --name "terraformsshkey" --value "VALUE"
az keyvault secret set --vault-name "$VAULT_NAME" --name "terraformsshkeypub" --value "VALUE"
