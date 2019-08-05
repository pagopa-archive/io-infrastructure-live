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

    protocols = "https"
  },
  {
    name         = "digital-citizenship-api"
    display_name = "Digital Citizenship API"
    description  = "Digital Citizenship API."
    revision     = "3"
    path         = "api/v1"

    protocols = "https"
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
