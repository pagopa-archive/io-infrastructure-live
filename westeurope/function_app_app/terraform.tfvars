# Creates a Kubernetes Cluster through AKS using the Kubenet CNI.
# For more info look at the README.md file of the module.

terragrunt = {
  dependencies {
    paths = [
      "../subnet_k8s_01",
      "../cosmosdb_sql_database",
      "../subnet_functions",
      "../storage_account_functions",
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

plan_name            = "fn2app"
storage_account_name = "fn2app"
functionapp_name     = "2-app"

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
    name  = "SUBSCRIPTIONS_FEED_TABLE"
    value = "SubscriptionsFeedByDay"
  }
]

functionapp_settings_secrets = [
  {
    name        = "PUBLIC_API_KEY"
    vault_alias = "fn2appPublicApiKey"
  },
  {
    name        = "APPINSIGHTS_INSTRUMENTATIONKEY"
    vault_alias = "fn2appAppInsightsInstrumentationKey"
  },
  {
    name        = "QueueStorageConnection"
    vault_alias = "fn2appQueueStorageConnection"
  },
]

functionapp_connection_strings = [
  {
    name        = "COSMOSDB_KEY"
    vault_alias = "fn2appCosmosdbKey"
  },
  {
    name        = "COSMOSDB_URI"
    vault_alias = "fn2appCosmosdbUri"
  },
]
