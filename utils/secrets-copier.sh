#!/usr/bin/env bash

# The *secrets-copier.sh* scripts allows to copy a pre-defined list
# of secrets between two keyvaults of the same subscription.

# To start the copy, simply make sure the name of the source and
# the destination vaults are up to date, and that the list of secrets
# reflects the ones you have to copy. Then execute it running
# `bash secrets-copier.sh` or `./secrets-copier.sh`.

# WARNING:
# The following certificates won't be imported. The right
# certificates need to be imported manually in the destination keyvault
# generated-cert
# k8s-io-onboarding-pa-api-secrets-spid-certs
# k8s-app-backend-secrets-spid-certs
# k8s-pagopa-proxy-test-secrets-io-certs

src_vault_name="io-dev-keyvault"
dst_vault_name="io-prod-keyvault"

secrets=(
  # Functions
  "fn2-commons-mailup-username"
  "fn2-commons-mailup-secret"
  "fn2-app-public-api-key"
  "fn2-services-webhook-channel-url"
  # Apim
  "apim-01-fn2-admin-host-key"
  "apim-01-fn2-services-host-key"
  # Application gateway
  "application-gateway-to-apim-01-cert"
  # Notification hub
  "notification-hub-01-bundle-id"
  "notification-hub-01-gc-m-key"
  "notification-hub-01-key-id"
  "notification-hub-01-team-id"
  "notification-hub-01-token"
  # Kubernetes
  "k8s-app-backend-secrets"
  "k8s-developer-portal-backend-secrets"
  "k8s-pagopa-proxy-prod-secrets"
  "k8s-pagopa-proxy-test-secrets"
  "k8s-pagopa-proxy-test-secrets-pagopa-ca-chain-certs"
  # Monitoring
  "app-insight-web-tests-ocp-apim-subscription-key"
)

for secret in "${secrets[@]}"; do
  echo -e "Processing secret $secret"
  value=$(az keyvault secret show --vault-name io-dev-keyvault --name "$secret" | jq -r '.value')
  az keyvault secret import --vault-name "$dst_vault_name" --name "$secret" --value "$value" > /dev/null
done
