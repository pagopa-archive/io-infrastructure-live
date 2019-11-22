# Creates a Kubernetes Cluster through AKS using the Kubenet CNI.
# For more info look at the README.md file of the module.

terragrunt = {
  dependencies {
    paths = [
      "../function_app_service_plan_fn2services",
      "../cosmosdb_account_01",
      "../storage_account_appdata",
      "../storage_account_fn2services"
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

plan_name            = "fn2services"
storage_account_name = "fn2services"
functionapp_name     = "2-services"

functionapp_settings = [
  {
    name  = "COSMOSDB_NAME"
    value = "io-dev-sqldb-db-01"
  },
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
    name  = "MESSAGE_CONTAINER_NAME"
    value = "message-content"
  },
  {
    name  = "PUBLIC_API_URL"
    value = "https://io-dev-apim-01.azure-api.net"
  },
  {
    name  = "WEBSITE_HTTPSCALEV2_ENABLED"
    value = "1"
  },
  {
    name  = "FUNCTIONS_EXTENSION_VERSION"
    value = "~2"
  },
  {
    name  = "MAIL_FROM_DEFAULT"
    value = "IO - l'app dei servizi pubblici <no-reply@io.italia.it>"
  },
  {
    name  = "SUBSCRIPTIONS_FEED_TABLE"
    value = "SubscriptionsFeedByDay"
  }
]

functionapp_settings_secrets = [
  {
    name        = "APPINSIGHTS_INSTRUMENTATIONKEY"
    vault_alias = "fn2-commons-app-insights-instrumentation-key"
  },
  {
    name        = "QueueStorageConnection"
    vault_alias = "fn2-commons-sa-appdata-primary-connection-string"
  },
  {
    name        = "MAILUP_USERNAME"
    vault_alias = "fn2-commons-mailup-username"
  },
  {
    name        = "MAILUP_SECRET"
    vault_alias = "fn2-commons-mailup-secret"
  },
  {
    name        = "WEBHOOK_CHANNEL_URL"
    vault_alias = "fn2-services-webhook-channel-url"
  }
]

functionapp_connection_strings = [
  {
    name        = "COSMOSDB_KEY"
    vault_alias = "fn2CommonCosmosdbKey"
  },
  {
    name        = "COSMOSDB_URI"
    vault_alias = "fn2CommonCosmosdbUri"
  }
]
