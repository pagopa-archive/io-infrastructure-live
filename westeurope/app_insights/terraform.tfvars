# The module creates and configure application insights

# Existing infrastructure
terragrunt = {
  dependencies {
    paths = [
      "../resource_group"
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_app_insights"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# New infrastructure

applications_insights = [
  {
    azurerm_application_insights_application_type  = "web"
    azurerm_application_insights_name              = "01"
  },
  {
    azurerm_application_insights_application_type  = "other"
    azurerm_application_insights_name              = "02"
  }
]
