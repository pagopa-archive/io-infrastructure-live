terragrunt = {
  dependencies {
    paths = [
      "../../api_management"
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_api_management_properties"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Azure API Management module variables

apim_name = "01"

function_app_name = "2-onboarding"

apim_groups = []

apim_named_values = [
  {
    name  = "OnboardingFunctionAppBaseUrl"
    value = "https://io-dev-fn-2-onboarding.azurewebsites.net"
  }
]

apim_secret_named_values = [
  {
    name        = "OnboardingFunctionAppHostKey"
    vault_alias = "apim-01-fn2-onboarding-host-key"
  }
]
