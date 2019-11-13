terragrunt = {
  dependencies {
    paths = [
      "../api_management",
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_api_management_apis"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Azure API Management module variables

apim_name = "01"

apim_apis = [
  {
    name         = "io-admin"
    display_name = "IO API for administration purpose"
    description  = "IO API for administration purpose"
    revision     = "1"
    path         = ""
    host         = "api.prod.io.italia.it"
    protocols    = "http,https"
  },
  {
    name         = "io-api"
    display_name = "IO API for Services"
    description  = "IO API for Services."
    revision     = "3"
    path         = "api/v1"
    host         = "api.prod.io.italia.it"
    protocols    = "http,https"
  },
]
