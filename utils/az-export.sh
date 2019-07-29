#!/usr/bin/env bash

# Azure export script
#
# It exports environment variables used by other tools
# used to provision and maintain the Azure infrastructure.
#
# teamdigitale.governo.it

set -e
set -u

if [ ! -f .env ]; then
  echo """
  ERROR:
  .env file missing. Please copy the .env.example file into a .env file
  and customize it with your deployment values. Then, run this script again.
  """
  exit -1
fi

source .env

# Set account subscription
run_cmd az account set -s ${SUBSCRIPTION}

export SUBSCRIPTION=${SUBSCRIPTION}
export RG_NAME=${RG_NAME}
export VAULT_NAME=${VAULT_NAME}
export DEFAULT_ADMIN_USER=${DEFAULT_ADMIN_USER}
export TF_VAR_default_admin_username=${DEFAULT_ADMIN_USER}
export TERRAFORM_STORAGE_ACCOUNT_NAME=${TERRAFORM_STORAGE_ACCOUNT_NAME}
export TERRAFORM_CONTAINER_NAME=${TERRAFORM_CONTAINER_NAME}
export ARM_ACCESS_KEY=$(az keyvault secret show --name ${TERRAFORM_VAULT_KEY_STORAGE_ACCOUNT} --vault-name ${VAULT_NAME} --query value -o tsv)
export PACKER_SP_ID=$(az ad sp list --display-name ${PACKER_SP_NAME} --query '[0].{"id":"appId"}' -o tsv)
export PACKER_SP_SECRET=$(az keyvault secret show --name ${PACKER_VAULT_KEY} --vault-name ${VAULT_NAME} --query value -o tsv)
