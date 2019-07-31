terragrunt = {
  # dependencies {  #   paths = [  #     "../resource_group"  #   ]  # }

  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_api_management"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Azure API Management module variables

apim_name = "01"

virtualNetworkType = "external"

vnet_name = "common"

subnet_name = "apim"

function_app_name = "1-01"

publisher_name = "Digital Citizenship"

publisher_email = "io-dev@agid.gov.it"

notification_sender_email = "io-dev@agid.gov.it"

sku_name = "Developer"

ADB2C_TENANT_ID = "cb44f084-ca44-4753-8973-dd3045d9ad2b"

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

apim_products = [
  {
    id                  = "io-dev-apim-prod-01"
    display_name        = "Digital Citizenship (alpha)"
    description         = "Subscribers will be able to integrate with the alpha version Digital Citizenship API"
    subscriptions_limit = "100"
  },
]

apim_product_policies = [
  {
    product_id = "io-dev-apim-prod-01"

    xml_content = <<XML
<!--
    IMPORTANT:
    - Policy elements can appear only within the <inbound>, <outbound>, <backend> section elements.
    - To apply a policy to the incoming request (before it is forwarded to the backend service), place a corresponding policy element within the <inbound> section element.
    - To apply a policy to the outgoing response (before it is sent back to the caller), place a corresponding policy element within the <outbound> section element.
    - To add a policy, place the cursor at the desired insertion point and select a policy from the sidebar.
    - To remove a policy, delete the corresponding policy statement from the policy document.
    - Position the <base> element within a section element to inherit all policies from the corresponding section element in the enclosing scope.
    - Remove the <base> element to prevent inheriting policies from the corresponding section element in the enclosing scope.
    - Policies are applied in the order of their appearance, from the top down.
    - Comments within policy elements are not supported and may disappear. Place your comments between policy elements or at a higher level scope.
-->
<policies>
    <inbound>
        <base />
    </inbound>
    <backend>
        <base />
    </backend>
    <outbound>
        <base />
    </outbound>
    <on-error>
        <base />
    </on-error>
</policies>
XML
  },
]

apim_apis = [
  {
    name         = "digital-citizenship-admin"
    display_name = "Digital Citizenship (admin)"
    revision     = "1"
    path         = ""

    # protocols    = ["https"]
  },
  {
    name         = "digital-citizenship-api"
    display_name = "Digital Citizenship API"
    description  = "Digital Citizenship API."
    revision     = "3"
    path         = "api/v1"

    # protocols    = ["https"]
  },
]

apim_properties = [
  {
    name  = "backendUrl"
    value = "https://dev-functions-test.azurewebsites.net"
  },
]

apim_product_api_bindings = [
  {
    api_name   = "digital-citizenship-admin"
    product_id = "io-dev-apim-prod-01"
  },
  {
    api_name   = "digital-citizenship-api"
    product_id = "io-dev-apim-prod-01"
  },
]

apim_api_operations = [
  {
    api_name     = "digital-citizenship-admin"
    operation_id = "createService"
    display_name = "Create"
    method       = "POST"
    url_template = "/adm/services"

    description = "This can only be done by the logged in user."

    templateParameters = []

    request  = []
    response = []
  },
]

apim_api_operation_policies = [
  {
    api_name     = "digital-citizenship-admin"
    operation_id = "createService"

    xml_content = <<XML
<!--
    IMPORTANT:
    - Policy elements can appear only within the <inbound>, <outbound>, <backend> section elements.
    - To apply a policy to the incoming request (before it is forwarded to the backend service), place a corresponding policy element within the <inbound> section element.
    - To apply a policy to the outgoing response (before it is sent back to the caller), place a corresponding policy element within the <outbound> section element.
    - To add a policy, place the cursor at the desired insertion point and select a policy from the sidebar.
    - To remove a policy, delete the corresponding policy statement from the policy document.
    - Position the <base> element within a section element to inherit all policies from the corresponding section element in the enclosing scope.
    - Remove the <base> element to prevent inheriting policies from the corresponding section element in the enclosing scope.
    - Policies are applied in the order of their appearance, from the top down.
    - Comments within policy elements are not supported and may disappear. Place your comments between policy elements or at a higher level scope.
-->
<policies>
    <inbound>
        <base />
    </inbound>
    <backend>
        <base />
    </backend>
    <outbound>
        <base />
    </outbound>
    <on-error>
        <base />
    </on-error>
</policies>
XML
  },
]
