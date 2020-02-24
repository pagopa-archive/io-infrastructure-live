terragrunt = {
  dependencies {
    paths = [
      "../api_management"
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

function_app_name = "2-services"

apim_groups = [
  {
    name = "ApiAdmin"
  },
  {
    name = "ApiDebugRead"
  },
  {
    name = "ApiFullProfileRead"
  },
  {
    name = "ApiInfoRead"
  },
  {
    name         = "apilimitedmessagewrite"
    display_name = "ApiLimitedMessageWrite"
  },
  {
    name = "ApiLimitedProfileRead"
  },
  {
    name = "ApiMessageList"
  },
  {
    name = "ApiMessageRead"
  },
  {
    name = "ApiMessageWrite"
  },
  {
    name        = "ApiMessageWriteDefaultAddress"
    description = "messages: ability to set default address when sending a message"
  },
  {
    name        = "ApiMessageWriteDryRun"
    description = "messages: send messages in dry run mode"
  },
  {
    name = "ApiProfileWrite"
  },
  {
    name = "ApiServiceKeyRead"
  },
  {
    name = "ApiServiceKeyWrite"
  },
  {
    name = "ApiServiceList"
  },
  {
    name = "ApiPublicServiceList"
  },
  {
    name = "ApiPublicServiceRead"
  },
  {
    name = "ApiServiceByRecipientQuery"
  },
  {
    name         = "apiserviceread"
    display_name = "ApiServiceRead"
  },
  {
    name         = "apiservicewrite"
    display_name = "ApiServiceWrite"
  },
  {
    name = "ApiSubscriptionsFeedRead"
  },
  {
    name = "ApiDevelopmentProfileWrite"
  },
  {
    name = "ApiUserAdmin"
  }
]

apim_named_values = [
  {
    name  = "ServiceFunctionAppBaseUrl"
    value = "https://io-dev-fn-2-services.azurewebsites.net"
  },
  {
    name  = "AdminFunctionAppBaseUrl"
    value = "https://io-dev-fn-2-admin.azurewebsites.net"
  },
  {
    name  = "PublicFunctionAppBaseUrl"
    value = "https://io-dev-fn-2-public.azurewebsites.net"
  }
]

apim_secret_named_values = [
  {
    name        = "ServiceFunctionAppHostKey"
    vault_alias = "apim-01-fn2-services-host-key"
  },
  {
    name        = "AdminFunctionAppHostKey"
    vault_alias = "apim-01-fn2-admin-host-key"
  },
  {
    name        = "PublicFunctionAppHostKey"
    vault_alias = "apim-01-fn2-public-host-key"
  }
]
