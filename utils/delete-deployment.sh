#!/usr/bin/env bash

resource_group=io-prod-rg
parallelism=20

function delete {
  while [[ $(ps aux | grep -i "az group deployment delete" | wc -l) -gt $parallelism ]];
  do
    sleep 1
  done
  az group deployment delete -g $resource_group --name $1 &
}

# Main
for result in $(az group deployment list -g $resource_group | jq -r '.[].name');
do
  delete "$result"
done
