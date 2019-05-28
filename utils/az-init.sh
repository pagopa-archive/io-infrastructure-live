#!/usr/bin/env bash

# Azure init script
# 
# It initializes the Azure infrastructure, in order to
# be then provisioned with Packer and Terraform.
# 
# teamdigitale.governo.it

set -o pipefail
set -o nounset
# set -o xtrace

if [ ! -f .env ]; then
  echo """
  ERROR:
  .env file missing. Please copy the .env.example file into a .env file
  and customize it with your deployment values. Then, run this script again.
  """
  exit -1
fi

source .env

function generate_random_pwd() {
  echo $(LC_ALL=C tr -dc 'A-Za-z0-9!"#$%&'\''()*+,-./:;<=>?@[\]^_{|}~' </dev/urandom | head -c 20)
}

# Set account subscription
run_cmd az account set -s ${SUBSCRIPTION}

run_cmd az group create --location ${LOCATION}\
  --subscription ${SUBSCRIPTION}\
  --name ${RG_NAME}

# Create the infrastructure vault
run_cmd az keyvault create --name ${VAULT_NAME}\
  --resource-group ${RG_NAME}\
  --location ${LOCATION}\
  --output none

az keyvault secret show --name ${DEFAULT_SSH_PRIVATE_KEY_VAULT_KEY}\
  --vault-name ${VAULT_NAME} > /dev/null 2>&1)
last_result=$(echo $?)

### Terraform specific

# Create storage account to store the Terraform states and save
# the secret in the vault
run_cmd az storage account create --resource-group ${RG_NAME}\
  --name ${TERRAFORM_STORAGE_ACCOUNT_NAME}\
  --sku Standard_LRS\
  --encryption-services blob

TERRAFORM_ACCOUNT_KEY=$(az storage account keys list --resource-group ${RG_NAME}\
  --account-name ${TERRAFORM_STORAGE_ACCOUNT_NAME}\
  --query [0].value -o tsv)

run_cmd az storage container create --name $TERRAFORM_CONTAINER_NAME\
  --account-name ${TERRAFORM_STORAGE_ACCOUNT_NAME}\
  --account-key ${TERRAFORM_ACCOUNT_KEY}

run_cmd az keyvault secret set --name ${TERRAFORM_VAULT_KEY_STORAGE_ACCOUNT}\
  --vault-name ${VAULT_NAME}\
  --value ${TERRAFORM_ACCOUNT_KEY}
