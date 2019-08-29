#!/usr/bin/env bash

# Azure API Management Services (APIMs) sync tool

# Reads a template.json file in input (manually exported from the original APIM)
# and creates users, groups, subscriptions on the new APIM

# The input file template.json should be in the same directory where the script
# is run from.

# TODO: produce a full export of the API Management config

# Destination APIM settings
DST_APIM_NAME=io-dev-apim-01
DST_APIM_PRODUCT_NAME=io-dev-apim-prod-01
DST_RESOURCE_GROUP=io-dev-rg

DRY_RUN=0

NOW=$(date '+%Y-%m-%d-%H%M%S')

echo "Started at $NOW"
echo "Processing Users .."

USERS=$(cat template.json | jq -r '[ .resources[] | select( (.type | contains("Microsoft.ApiManagement/service/users")) and (.name | contains("/1") | not )) | del(.dependsOn) ]')

echo " 
   {
    \"\$schema\": \"https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#\",
    \"contentVersion\": \"1.0.0.0\",
    \"parameters\": {
        \"service_agid_apim_prod_name\": {
            \"defaultValue\": \"$DST_APIM_NAME\",
            \"type\": \"String\"
        }
    },
    \"variables\": {},
    \"resources\": $USERS
}
" >apim-users.json

if ! $DRY_RUN; then
    echo "Deploying ARM template .."
    az group deployment create --name USER-SYNC-JOB-$NOW --resource-group $DST_RESOURCE_GROUP --template-file apim-users.json
    az group deployment wait --name USER-SYNC-JOB-$NOW --resource-group $DST_RESOURCE_GROUP --updated
fi
echo "Completed."

echo "Processing Group Membership.."

GROUP_MEMBERSHIP=$(cat template.json | jq -r '[ .resources[] | select( (.type | contains("Microsoft.ApiManagement/service/groups/users"))  and (.name | contains("/developers") | not )) | del(.dependsOn) ]')

GROUP_MEMBERSHIP_COUNT=$(echo $GROUP_MEMBERSHIP | jq ' length')
echo "$GROUP_MEMBERSHIP_COUNT group memberships found."
echo " 
   {
    \"\$schema\": \"https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#\",
    \"contentVersion\": \"1.0.0.0\",
    \"parameters\": {
        \"service_agid_apim_prod_name\": {
            \"defaultValue\": \"$DST_APIM_NAME\",
            \"type\": \"String\"
        }
    },
    \"variables\": {},
    \"resources\": $GROUP_MEMBERSHIP
}
" >apim-group-membership.json
if ! $DRY_RUN; then
    echo "Deploying ARM template .."
    az group deployment create --name GROUP-MEMBERSHIP-SYNC-JOB-$NOW --resource-group $DST_RESOURCE_GROUP --template-file apim-group-membership.json
    az group deployment wait --name GROUP-MEMBERSHIP-SYNC-JOB-$NOW --resource-group $DST_RESOURCE_GROUP --updated
fi
echo "Completed."

echo "Processing Subscriptions.."
SUBSCRIPTIONS=$(cat template.json | jq -r '[ .resources[] | select( (.type | contains("Microsoft.ApiManagement/service/subscriptions")) and (.name | contains("/master") | not )  and (.name | contains("/azure-deploy") | not )) | del(.dependsOn) ]')

# Replace source product name with the destination product name
SUBSCRIPTIONS=$(echo ${SUBSCRIPTIONS//$SRC_APIM_PRODUCT_NAME/$DST_APIM_PRODUCT_NAME})

SUBSCRIPTIONS_COUNT=$(echo $SUBSCRIPTIONS | jq ' length')
echo "$SUBSCRIPTIONS_COUNT subscriptions found."
echo " 
   {
    \"\$schema\": \"https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#\",
    \"contentVersion\": \"1.0.0.0\",
    \"parameters\": {
        \"service_agid_apim_prod_name\": {
            \"defaultValue\": \"$DST_APIM_NAME\",
            \"type\": \"String\"
        }
    },
    \"variables\": {},
    \"resources\": $SUBSCRIPTIONS
}
" >apim-subscriptions.json

NOW=$(date '+%Y-%m-%d-%H%M%S')
if ! $DRY_RUN; then
    echo "Deploying ARM template .."
    az group deployment create --name SUBSCRIPTIONS-SYNC-JOB-$NOW --resource-group $DST_RESOURCE_GROUP --template-file apim-subscriptions.json
    az group deployment wait --name SUBSCRIPTIONS-SYNC-JOB-$NOW --resource-group $DST_RESOURCE_GROUP --updated
fi
echo "Completed."
