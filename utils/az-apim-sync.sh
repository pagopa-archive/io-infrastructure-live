#!/usr/bin/env bash

# Azure API Management Services (APIMs) sync tool

# Reads a template.json file in input (manually exported from the original APIM)
# and creates users, groups, subscriptions on the new APIM

# The input file template.json should be in the same directory where the script
# is run from.

# TODO: produce a full export of the API Management config

# Destination APIM settings
DST_APIM_NAME=io-prod-apim-01
SRC_APIM_PRODUCT_NAME=starter
DST_APIM_PRODUCT_NAME=io-prod-apim-prod-01
DST_RESOURCE_GROUP=io-prod-rg

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

USERS_COUNT=$(echo $USERS | jq ' length')
echo "... $USERS_COUNT users found."

if [[ $DRY_RUN -ne 1 ]]; then
    echo "... Deploying ARM template .."
    az group deployment create --name USER-SYNC-JOB-$NOW --resource-group $DST_RESOURCE_GROUP --template-file apim-users.json
    az group deployment wait --name USER-SYNC-JOB-$NOW --resource-group $DST_RESOURCE_GROUP --updated
else
    echo "... Dry Run is enabled, deployment disabled."
fi
echo "... Completed."

echo "Processing Group Memberships.."

GROUP_MEMBERSHIP=$(cat template.json | jq -r '[ limit( 800; .resources[]) | select( (.type | contains("Microsoft.ApiManagement/service/groups/users"))  and (.name | contains("/developers") | not ) and (.name | contains("/1") | not ) ) | del(.dependsOn) ]')

# GROUP_MEMBERSHIP=$(cat template.json | jq -r '[ .resources[] | select( (.type | contains("Microsoft.ApiManagement/service/groups/users"))  and (.name | contains("/developers") | not )) | del(.dependsOn) ]')
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

GROUP_MEMBERSHIP_COUNT=$(echo $GROUP_MEMBERSHIP | jq ' length')
echo "... $GROUP_MEMBERSHIP_COUNT group memberships found."
if [[ $GROUP_MEMBERSHIP_COUNT -gt 800 ]]; then
    echo "... WARNING! The number of template resources limit exceeded. Limit: 800 and actual: $GROUP_MEMBERSHIP_COUNT. Limiting sync to the first 800 resources"
    # LIMITED_GROUP_MEMBERSHIP=$(cat apim-group-membership.json | jq -r '[ limit( 800; .resources[] ) ]')
    # echo "$LIMITED_GROUP_MEMBERSHIP" >apim-group-membership.json
fi

if [[ $DRY_RUN -ne 1 ]]; then
    echo "... Deploying ARM template .."
    az group deployment create --name GROUP-MEMBERSHIP-SYNC-JOB-$NOW --resource-group $DST_RESOURCE_GROUP --template-file apim-group-membership.json
    az group deployment wait --name GROUP-MEMBERSHIP-SYNC-JOB-$NOW --resource-group $DST_RESOURCE_GROUP --updated
else
    echo "... Dry Run is enabled, deployment disabled."
fi
echo "... Completed."

echo "Processing Subscriptions.."
SUBSCRIPTIONS=$(cat template.json | jq -r '[ .resources[] | select( (.type | contains("Microsoft.ApiManagement/service/subscriptions")) and (.name | contains("/master") | not )) | del(.dependsOn) ]')

# Replace source product name with the destination product name
SUBSCRIPTIONS=$(echo ${SUBSCRIPTIONS//$SRC_APIM_PRODUCT_NAME/$DST_APIM_PRODUCT_NAME})

SUBSCRIPTIONS_COUNT=$(echo $SUBSCRIPTIONS | jq ' length')
echo "... $SUBSCRIPTIONS_COUNT subscriptions found."
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
if [[ $DRY_RUN -ne 1 ]]; then
    echo "... Deploying ARM template .."
    az group deployment create --name SUBSCRIPTIONS-SYNC-JOB-$NOW --resource-group $DST_RESOURCE_GROUP --template-file apim-subscriptions.json
    az group deployment wait --name SUBSCRIPTIONS-SYNC-JOB-$NOW --resource-group $DST_RESOURCE_GROUP --updated
else
    echo "... Dry Run is enabled, deployment disabled."
fi
echo "... Completed."

NOW=$(date '+%Y-%m-%d-%H%M%S')

echo "Finished at $NOW"
