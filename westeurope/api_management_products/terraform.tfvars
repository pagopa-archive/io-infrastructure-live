terragrunt = {
  dependencies {
    paths = [
      "../api_management_apis",
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_api_management_products"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Azure API Management module variables

apim_name = "01"

apim_products = [
  {
    id                  = "io-dev-apim-prod-01"
    display_name        = "Digital Citizenship (alpha)"
    description         = "Subscribers will be able to integrate with the alpha version Digital Citizenship API"
    subscriptions_limit = "100"

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
