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
    revision     = "1"
    path         = ""
    host         = "api.dev.io.italia.it"
    protocols    = "https"
  },
  {
    name         = "io-services"
    display_name = "IO API for Services"
    description  = "IO API for Services."
    revision     = "3"
    path         = "api/v1"
    host         = "api.dev.io.italia.it"
    protocols    = "https"
  },
]

apim_api_operation_policies = [
  {
    api_name     = "io-admin"
    operation_id = "createService"
  },
  {
    api_name     = "io-admin"
    operation_id = "updateService"
  },
  {
    api_name     = "io-admin"
    operation_id = "getService"
  },
  {
    api_name     = "io-admin"
    operation_id = "createDevelopmentProfile"
  },
  {
    api_name     = "io-services"
    operation_id = "getMessage"
  },
  {
    api_name     = "io-services"
    operation_id = "getProfile"
  },
  {
    api_name     = "io-services"
    operation_id = "submitMessageforUser"
  },
  {
    api_name     = "io-services"
    operation_id = "getsubscriptionsfeedfordate"
  },
]
