#!/usr/bin/env bash
# Azure API Management Services (APIMs) sync tool
# Reads a template.json file in input (manually exported from the original APIM)
# and creates users, groups, subscriptions on the new APIM
# The input file template.json should be in the same directory where the script
# is run from.
# Destination APIM settings
DST_APIM_NAME=io-prod-apim-01
SRC_APIM_PRODUCT_NAME=starter
DST_APIM_PRODUCT_NAME=io-prod-apim-prod-01
DST_RESOURCE_GROUP=io-prod-rg
DRY_RUN=0
# PAGINATION SETTINGS
RESOURCE_COUNT_PAGINATION=700
NOW=$(date '+%Y-%m-%d-%H%M%S')
function generate_arm_template {
    local LIMIT_DOWN=0
    local RESOURCE_TYPE=$1
    local CONTAINS=$2
    
    IFS='/' read -ra RESOURCE_TYPE_ARRAY <<< "$RESOURCE_TYPE"
    RESOURCE_NAME="${RESOURCE_TYPE_ARRAY[2]}"
    # Number of ARM resources
    RESOURCE_COUNT=$(cat template.json | jq -r --arg RESOURCE_TYPE "$RESOURCE_TYPE" --arg CONTAINS "$CONTAINS" '[ .resources[] | select( (.type | contains($RESOURCE_TYPE))  and (.name | contains($CONTAINS) | not )) | del(.dependsOn)]' | jq 'length')
    echo "... $RESOURCE_COUNT resources found."
    if [[ $RESOURCE_COUNT -lt $RESOURCE_COUNT_PAGINATION ]]
    then
        LIMIT_UP=$RESOURCE_COUNT
    else
        LIMIT_UP=$RESOURCE_COUNT_PAGINATION
    fi
    while [[ $LIMIT_DOWN -lt $RESOURCE_COUNT ]] 
    do 
        RESOURCES=$(cat template.json | jq -r --arg LIMIT_DOWN "$LIMIT_DOWN" --arg LIMIT_UP "$LIMIT_UP" --arg RESOURCE_TYPE "$RESOURCE_TYPE" --arg CONTAINS "$CONTAINS" '[ .resources[] | select( (.type | contains($RESOURCE_TYPE))  and (.name | contains($CONTAINS) | not )) | del(.dependsOn) ] | .[$LIMIT_DOWN|tonumber:$LIMIT_UP|tonumber]')
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
            \"resources\": $RESOURCES
        }
        " >apim-$RESOURCE_NAME-$LIMIT_DOWN-$LIMIT_UP.json
        if [[ $DRY_RUN -ne 1 ]]; then
            echo "... Deploying ARM template $RESOURCE_NAME from $LIMIT_DOWN to $LIMIT_UP"
            az group deployment create --name $RESOURCE_NAME-SYNC-JOB-$NOW-$LIMIT_DOWN-$LIMIT_UP --resource-group $DST_RESOURCE_GROUP --template-file apim-$RESOURCE_NAME-$LIMIT_DOWN-$LIMIT_UP.json
            az group deployment wait --name $RESOURCE_NAME-SYNC-JOB-$NOW-$LIMIT_DOWN-$LIMIT_UP --resource-group $DST_RESOURCE_GROUP --updated
        else
            echo "... Dry Run is enabled, deployment disabled."
        fi
        let LIMIT_DOWN=LIMIT_UP+1
        let LIMIT_CHECK=$RESOURCE_COUNT-$LIMIT_UP
        if [[ $LIMIT_CHECK -lt $RESOURCE_COUNT_PAGINATION ]]
        then
            let LIMIT_UP=$LIMIT_UP+$LIMIT_CHECK
        else
            let LIMIT_UP=$LIMIT_UP+$RESOURCE_COUNT_PAGINATION
        fi
    done
    echo "... finishing ARM template $RESOURCE_NAME from $LIMIT_DOWN to $LIMIT_UP "
}
# MAIN
generate_arm_template "Microsoft.ApiManagement/service/users" "/1"
generate_arm_template "Microsoft.ApiManagement/service/groups/users" "/developers"
generate_arm_template "Microsoft.ApiManagement/service/subscriptions" "/master"
