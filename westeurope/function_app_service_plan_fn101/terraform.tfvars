terragrunt = {
  dependencies {
    paths = [
      "../resource_group"
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_app_service_plan"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# App service plan specific variables
azurerm_app_service_plan_kind                         = "elastic"
azurerm_app_service_plan_sku_tier                     = "ElasticPremium"
azurerm_app_service_plan_sku_size                     = "EP1"
azurerm_app_service_plan_sku_capacity                 = "1"
azurerm_app_service_plan_suffix                       = "functions-01"
azurerm_app_service_plan_maximum_elastic_worker_count = "4"
