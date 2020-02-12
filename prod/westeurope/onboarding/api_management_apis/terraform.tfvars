terragrunt = {
  dependencies {
    paths = [
      "../../api_management"
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
    name            = "io-onboarding"
    display_name    = "IO API for onboarding purpose"
    description     = "IO API for onboarding purpose"

    # uncomment once https://github.com/terraform-providers/terraform-provider-azurerm/issues/3203 gets fixed
    # content_format  = "openapi-json"

    # until that, use
    # $ api-spec-converter --from=openapi_3 --to=swagger_2 --syntax=json io-onboarding/openapi.json > io-onboarding/swagger.json 

    revision        = "1"
    path            = "onboarding"
    host            = "api.io.italia.it"
    protocols       = "http"
  }
]
