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
    name         = "digital-citizenship-admin"
    display_name = "Digital Citizenship (admin)"
    revision     = "1"
    path         = ""
    host         = "api.dev.io.italia.it"
    protocols    = "https"
  },
  {
    name         = "digital-citizenship-api"
    display_name = "Digital Citizenship API"
    description  = "Digital Citizenship API."
    revision     = "3"
    path         = "api/v1"
    host         = "api.dev.io.italia.it"
    protocols    = "https"
  },
  {
    name         = "openapi-specs"
    display_name = "OpenAPI Specs"
    description  = "OpenAPI Specs."
    revision     = "1"
    path         = "specs/api/v1"
    host         = "api.dev.io.italia.it"
    protocols    = "https"
  },
]

apim_api_operation_policies = [
  {
    api_name     = "digital-citizenship-admin"
    operation_id = "createService"
  },
  {
    api_name     = "digital-citizenship-admin"
    operation_id = "debug"
  },
  {
    api_name     = "digital-citizenship-admin"
    operation_id = "updateService"
  },
  {
    api_name     = "digital-citizenship-admin"
    operation_id = "getService"
  },
  {
    api_name     = "digital-citizenship-api"
    operation_id = "getInfo"
  },
  {
    api_name     = "digital-citizenship-api"
    operation_id = "getMessage"
  },
  {
    api_name     = "digital-citizenship-api"
    operation_id = "getMessagesByUser"
  },
  {
    api_name     = "digital-citizenship-api"
    operation_id = "getProfile"
  },
  {
    api_name     = "digital-citizenship-api"
    operation_id = "getService"
  },
  {
    api_name     = "digital-citizenship-api"
    operation_id = "senderServices"
  },
  {
    api_name     = "digital-citizenship-api"
    operation_id = "submitMessageforUser"
  },
  {
    api_name     = "digital-citizenship-api"
    operation_id = "upsertProfile"
  },
  {
    api_name     = "digital-citizenship-api"
    operation_id = "visibleServices"
  },
  {
    api_name     = "openapi-specs"
    operation_id = "getOpenApi"
  },
]
