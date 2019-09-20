# The module creates and configure application insights web tests

# Existing infrastructure
terragrunt = {
  dependencies {
    paths = [
      "../app_insights_web_tests"
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_app_insights_web_tests"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# New infrastructure

azurerm_application_insight_suffix = "generic-web-tests"

web_tests = [
  {
    name = "web_test_spid"
    url  = "https://spid-testenv.dev.io.italia.it"
  },
  {
    name = "web_test_app_backend"
    url  = "https://app-backend.dev.io.italia.it"
  }
]
