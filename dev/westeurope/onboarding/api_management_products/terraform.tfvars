terragrunt = {
  dependencies {
    paths = [
      "../api_management_apis"
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

apim_name     = "01"

apim_products = [
  {
    id_suffix           = "prod-02"
    display_name        = "IO - Anonymous"
    description         = "Grants anonymous access to the underline APIs"
    subscriptions_limit = "100"
    admin_group         = "developers"

    subscription_required   = false
    approval_required       = false

    xml_content         = <<XML
<!--
            IMPORTANT:
            - Policy elements can appear only within the <inbound>, <outbound>, <backend> section elements.
            - Only the <forward-request> policy element can appear within the <backend> section element.
            - To apply a policy to the incoming request (before it is forwarded to the backend service), place a corresponding policy element within the <inbound> section element.
            - To apply a policy to the outgoing response (before it is sent back to the caller), place a corresponding policy element within the <outbound> section element.
            - To add a policy position the cursor at the desired insertion point and click on the round button associated with the policy.
            - To remove a policy, delete the corresponding policy statement from the policy document.
            - Position the <base> element within a section element to inherit all policies from the corresponding section element in the enclosing scope.
            - Remove the <base> element to prevent inheriting policies from the corresponding section element in the enclosing scope.
            - Policies are applied in the order of their appearance, from the top down.
        -->
<policies>
    <inbound>
        <rate-limit calls="1000" renewal-period="5" />
        <quota calls="100000" renewal-period="604800" />
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
  }
]

apim_product_api_bindings = [
  {
    api_name          = "io-onboarding"
    product_id_suffix = "prod-02"
  }
]
