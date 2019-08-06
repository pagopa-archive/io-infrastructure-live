#!/usr/bin/env bash

# Azure export script
#
# It exports environment variables used by other tools
# used to provision and maintain the Azure infrastructure.
#
# teamdigitale.governo.it

if [ ! -f .env ]; then
  echo """
  ERROR:
  .env file missing. Please copy the .env.example file into a .env file
  and customize it with your deployment values. Then, run this script again.
  """
  exit 1
fi

# shellcheck disable=SC1091
source .env

# Set account subscription
run_cmd az account set -s ${SUBSCRIPTION}

log_date "<Start loading variables>"

SUBSCRIPTION="${SUBSCRIPTION}"
RG_INFRA_NAME="${RG_INFRA_NAME}"
VAULT_INFRA_NAME="${VAULT_INFRA_NAME}"
TERRAFORM_STORAGE_ACCOUNT_NAME="${TERRAFORM_STORAGE_ACCOUNT_NAME}"
TERRAFORM_CONTAINER_NAME="${TERRAFORM_CONTAINER_NAME}"
ARM_ACCESS_KEY="$(az keyvault secret show --name ${TERRAFORM_VAULT_STORAGE_ACCOUNT_KEY} --vault-name ${VAULT_INFRA_NAME} --query value -o tsv)"

log_date "<Exporting variables>"

export SUBSCRIPTION
export RG_INFRA_NAME
export VAULT_INFRA_NAME
export TERRAFORM_STORAGE_ACCOUNT_NAME
export TERRAFORM_CONTAINER_NAME
export ARM_ACCESS_KEY

log_date "<Log variables>"

log_date "SUBSCRIPTION=${SUBSCRIPTION}"
log_date "RG_INFRA_NAME=${RG_INFRA_NAME}"
log_date "VAULT_INFRA_NAME=${VAULT_INFRA_NAME}"
log_date "TERRAFORM_STORAGE_ACCOUNT_NAME=${TERRAFORM_STORAGE_ACCOUNT_NAME}"
log_date "TERRAFORM_CONTAINER_NAME=${TERRAFORM_CONTAINER_NAME}"
log_date "ARM_ACCESS_KEY=${ARM_ACCESS_KEY}"
