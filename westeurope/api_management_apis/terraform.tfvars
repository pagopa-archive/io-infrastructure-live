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
]

# apim_api_operations = [
#   {
#     api_name     = "digital-citizenship-admin"
#     operation_id = "createService"
#     display_name = "Create"
#     method       = "POST"
#     url_template = "/adm/services"

#     description = "This can only be done by the logged in user."

# templateParameters = []

# request  = []
# response = []

#     xml_content = <<XML
# <policies>
#     <inbound>
#         <set-backend-service id="apim-generated-policy" base-url="{{backendUrl}}" />
#         <base />
#         <set-header name="x-user-id" exists-action="override">
#             <value>@(context.User.Id)</value>
#         </set-header>
#         <set-header name="x-user-groups" exists-action="override">
#             <value>@(String.Join(",", context.User.Groups.Select(g => g.Name)))</value>
#         </set-header>
#         <set-header name="x-subscription-id" exists-action="override">
#             <value>@(context.Subscription.Id)</value>
#         </set-header>
#         <set-header name="x-user-email" exists-action="override">
#             <value>@(context.User.Email)</value>
#         </set-header>
#         <set-header name="x-user-note" exists-action="override">
#             <value>@(Uri.EscapeUriString(context.User.Note != null ? context.User.Note : ""))</value>
#         </set-header>
#         <set-header name="x-functions-key" exists-action="override">
#             <value>{{code}}</value>
#         </set-header>
#     </inbound>
#     <outbound>
#         <base />
#     </outbound>
#     <backend>
#         <base />
#         <!--              { "azureResource": { "type": "funcapp", "id": "/subscriptions/b77298e2-ddab-4f40-850c-cdc71fdce6d8/resourceGroups/teamdigitale/providers/Microsoft.Web/sites/test-danilo" } }              -->
#     </backend>
#     <on-error>
#         <base />
#     </on-error>
# </policies>
# XML
#   },
# ]

#   {
#     api_name     = "digital-citizenship-admin"
#     operation_id = "debug"
#     display_name = "debug"
#     method       = "GET"
#     url_template = "/adm/debug"

#     description = "This can only be done by the logged in user."

#     # templateParameters = []

#     # request  = []
#     # response = []
#   },
#   {
#     api_name     = "digital-citizenship-admin"
#     operation_id = "getService"
#     display_name = "getService"
#     method       = "GET"
#     url_template = "/adm/services/{serviceId}"

#     description = "---"

#     # template_parameter = "{\"name\": \"serviceId\", \"required\": \"true\",\"values\": \"[]\",\"type\": \"null \"}"
#     template_parameter = "{\"name\": \"serviceId\", \"required\": \"true\",\"type\": \"null \"}"

#     # template_parameter = [
#     #   {
#     #     name     = "serviceId"
#     #     required = "true"
#     #     values   = []
#     #     type     = "null"
#     #   },
#     # ]

#     # request  = []
#     # response = []
#   },
#   {
#     api_name     = "digital-citizenship-admin"
#     operation_id = "updateService"
#     display_name = "updateService"
#     method       = "PUT"
#     url_template = "/adm/services/{serviceId}"

#     description = "---"

#     template_parameter = "{\"name\": \"serviceId\", \"required\": \"true\",\"type\": \"null \"}"

#     # request  = []
#     # response = []
#   },
# ]

apim_api_operation_policies = [
  {
    api_name     = "digital-citizenship-admin"
    operation_id = "createService"
    xml_filename = "createService.xml"
  },
  {
    api_name     = "digital-citizenship-admin"
    operation_id = "debug"
    xml_filename = "debug.xml"
  },
  {
    api_name     = "digital-citizenship-admin"
    operation_id = "updateService"
    xml_filename = "updateService.xml"
  },
  {
    api_name     = "digital-citizenship-admin"
    operation_id = "getService"
    xml_filename = "getService.xml"
  },
]
