# Creates a Kubernetes Cluster through AKS using the Kubenet CNI.
# For more info look at the README.md file of the module.

terragrunt = {
  dependencies {
    paths = [
      "../subnet_redis",
      "../storage_account_servicedata"
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_redis_cache"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Redis cache module variables
storage_account_name                                                  = "servicedata"
vnet_name                                                             = "common"
subnet_name                                                           = "redis"
redis_cache_name_suffix                                               = "cache-01"
azurerm_redis_cache_capacity                                          = 1
azurerm_redis_cache_shard_count                                       = 1
azurerm_redis_cache_redis_configuration_rdb_backup_frequency          = 360
azurerm_redis_cache_redis_configuration_rdb_backup_max_snapshot_count = 1
azurerm_redis_cache_redis_configuration_rdb_backup_enabled            = true
azurerm_redis_cache_private_static_ip_address                         = "172.16.48.254"
azurerm_redis_cache_family                                            = "P"
azurerm_redis_cache_sku_name                                          = "Premium"