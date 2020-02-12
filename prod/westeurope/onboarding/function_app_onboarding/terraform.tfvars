terragrunt = {
  dependencies {
    paths = [
      "../subnet_function_app_onboarding",
      "../storage_account_fn2onboarding",
      "../function_app_service_plan_fn2onboarding",
      "../postgresql_database",
      "../storage_website_logos",
      "../storage_account_documents",
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_function_app"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

plan_name            = "fn2onboarding"
storage_account_name = "fn2onboarding"
functionapp_name     = "2-onboarding"

functionapp_settings = [
  {
    name  = "FUNCTION_APP_EDIT_MODE"
    value = "readonly"
  },
  {
    name  = "WEBSITE_NODE_DEFAULT_VERSION"
    value = "10.14.1"
  },
  {
    name  = "WEBSITE_RUN_FROM_PACKAGE"
    value = "1" 
  },
  {
    name  = "WEBSITE_HTTPSCALEV2_ENABLED"
    value = "1"
  },
  {
    name  = "FUNCTIONS_EXTENSION_VERSION"
    value = "~2"
  }
]

functionapp_settings_secrets = [
  {
    name        = "APPINSIGHTS_INSTRUMENTATIONKEY"
    vault_alias = "fn2-commons-app-insights-instrumentation-key"
  }
]

functionapp_connection_strings = []
