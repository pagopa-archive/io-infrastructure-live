#!/usr/bin/env bash

# Azure API Management Services (APIMs) sync tool

# Reads a template.json file in input (manually exported from the original APIM)
# and creates users, groups, subscriptions on the new APIM
# The input file template.json should be in the same directory where the script
# is run from.

# Destination APIM settings
dst_resource_group=io-prod-rg
dst_apim_name=io-prod-apim-01
dst_apim_product_id=io-prod-apim-prod-01
dst_deployment_name=io-apim

# The APIM product id to copy data from
# Along the process, this will be changed to dst_apim_product_id
src_template_file=template.json
src_apim_product_id=starter
src_deployment_name=service_agid_apim_prod_name

# How many resources to import at each run (ARM limit 800)
resource_count_pagination=700

function usage {
echo """
Usage: az-apim-import [--help] [-d|--dry-run]
Import users, groups and subscriptions to an Azure APIM.
Options:
  -h, --help            display this help message
  -d, --dry-run         run in dry-run mode. Create files. Do not import resources.
"""
}

# Generates and uploads ARM templates to the destination APIM
# 
# Input values:
# $1 - resource_type: the type of resource to upload
# $2 - no_name:       the resource names to exclude form the import
function generate_arm_template {
  local limit_down=0
  local resource_type=$1
  local no_names=$2

  # The resource name is the second element of the string
  # resource_type in input, splitted using /
  IFS='/' read -ra resource_type_array <<< "$resource_type"
  resource_name="${resource_type_array[2]}"

  # Get the total number of resources
  resource_count=$(cat "$src_template_file" | jq -r --arg RESOURCE_TYPE "$resource_type" --arg NO_NAMES "$no_names" '[.resources[] | select((.type==$RESOURCE_TYPE) and (.name | test($NO_NAMES) | not)) | del(.dependsOn)] | length')
  echo -e "\n[$resource_name] $resource_count resources found"

  # Set the total number of resources, if it is lower then
  # the number of resources set for upload at each run.
  # Otherwise, set the limit
  if [[ $resource_count -lt $resource_count_pagination ]]
  then
    limit_up=$resource_count
  else
    limit_up=$resource_count_pagination
  fi

  # Divide the resources given in input in multiple files,
  # based on the pagination parameter set. Save each of them
  # in a file called apim-{RESOURCE-TYPE}-{LOWER-LIMIT}-{UPPER-LIMIT}.json.
  # Then, deploy them one by one, if dry_run is 0.
  while [[ $limit_down -lt $resource_count ]] 
  do
    echo "[$resource_name] Processing resources from $limit_down to $limit_up"
    resources=$(cat "$src_template_file" | jq -r --arg LIMIT_DOWN "$limit_down" --arg LIMIT_UP "$limit_up" --arg RESOURCE_TYPE "$resource_type" --arg NO_NAMES "$no_names" '[.resources[] | select((.type==$RESOURCE_TYPE) and (.name | test($NO_NAMES) | not)) | del(.dependsOn)] | .[$LIMIT_DOWN|tonumber:$LIMIT_UP|tonumber]')

    {
      echo "{"
      echo "  \"\$schema\": \"https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#\","
      echo "  \"contentVersion\": \"1.0.0.0\","
      echo "  \"parameters\": {"
      echo "    \"$dst_deployment_name\": {"
      echo "      \"defaultValue\": \"$dst_apim_name\","
      echo "      \"type\": \"String\""
      echo "    }"
      echo "  },"
      echo "  \"variables\": {},"
      echo "  \"resources\": $resources"
      echo "}"
    } > apim-$resource_name-$limit_down-$limit_up.json

    if [[ $dry_run = false ]]; then
      echo "[$resource_name] Deploying ARM template $resource_name from $limit_down to $limit_up"
      az group deployment create --name $resource_name-sync-job-$now-$limit_down-$limit_up --resource-group $dst_resource_group --template-file apim-$resource_name-$limit_down-$limit_up.json > /dev/null
      az group deployment wait --name $resource_name-sync-job-$now-$limit_down-$limit_up --resource-group $dst_resource_group --updated > /dev/null
    fi

    let limit_down=limit_up+1
    let limit_check=$resource_count-$limit_up

    if [[ $limit_check -lt $resource_count_pagination ]]
    then
      let limit_up=$limit_up+$limit_check
    else
      let limit_up=$limit_up+$resource_count_pagination
    fi
  done
}

# Main: import users, groups and subscriptions to the destination APIM
while [ $# -gt 0 ]; do
  case "$1" in
    --*=*)        dry_run="${1%%=*}"; shift; set -- "$dry_run" "$@" ;;
    -h|--help)    usage; exit 0; shift ;;
    -d|--dry-run) dry_run=true; shift ;;
    --)           shift; break ;;
    -*)           usage; echo "Invalid option: $1" 1>&2; exit 1;;
    *)            break ;;
  esac
done

now=$(date '+%Y-%m-%d-%H%M%S')

if [[ $dry_run = true ]]; then
  echo "[info] Dry-run mode is on. Resources won't be deployed"
else
  dry_run=false
  echo "[info] Dry-run mode if off. Resources will be deployed"
fi

# Cleanup old APIM product name and set the new one
awk -v src_apim_product_id="${src_apim_product_id}" -v dst_apim_product_id="${dst_apim_product_id}" '{gsub(src_apim_product_id,dst_apim_product_id)}1' "$src_template_file" > "$src_template_file".tmp && mv "$src_template_file".tmp "$src_template_file"

# Cleanup old APIM product name and set the new one
awk -v src_deployment_name="${src_deployment_name}" -v dst_deployment_name="${dst_deployment_name}" '{gsub(src_deployment_name,dst_deployment_name)}1' "$src_template_file" > "$src_template_file".tmp && mv "$src_template_file".tmp "$src_template_file"

generate_arm_template "Microsoft.ApiManagement/service/users" "\/1"
generate_arm_template "Microsoft.ApiManagement/service/groups" "\/administrators|\/developers|\/guests"
generate_arm_template "Microsoft.ApiManagement/service/subscriptions" "\/master"

echo -e "\n"
