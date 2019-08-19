terragrunt = {
  dependencies {
    paths = [
      "../api_management",
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

function_app_name = "1-01"

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
]

apim_named_values = [
  {
    name  = "FunctionAppBaseUrl"
    value = "https://io-dev-fn-1-01.azurewebsites.net"
  },
]

apim_secret_named_values = [
  {
    name        = "FunctionAppHostKey"
    vault_alias = "fn101FunctionAppHostKey"
  },
]

apim_users = [{
  user_id    = "k8s-app-backend"
  first_name = "k8s"
  last_name  = "app-backend"
  email      = "k8s-app-backend@io.italia.com"

  groups        = "ApiFullProfileRead,ApiServiceRead,ApiPublicServiceList,ApiServiceByRecipientQuery,ApiMessageRead,ApiMessageList,ApiInfoRead"
  subscriptions = "io-dev-apim-prod-01"
}]
