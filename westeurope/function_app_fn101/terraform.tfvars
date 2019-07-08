# Creates a Kubernetes Cluster through AKS using the Kubenet CNI.
# For more info look at the README.md file of the module.

terragrunt = {
  dependencies {
    paths = [
      "../subnet_k8s_01",
      "../cosmosdb_sql_database",
      "../subnet_functions",
      "../storage_account_functions"
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

plan_name                      = "premium-plan"
storage_account_name           = "fn101"
functionapp_name               = "1-01"

functionapp_settings           = [
  {
    name  = "AzureWebJobsSecretStorageType"
    value = "disabled"
  },
  {
    name  = "COSMOSDB_NAME"
    value = "io-documentdb-dev"
  },
  {
    name  = "DIAGNOSTICS_AZUREBLOBRETENTIONINDAYS"
    value = 1
  },
  {
    name  = "FUNCTION_APP_EDIT_MODE"
    value = "readonly"
  },
  {
    name  = "FUNCTIONS_EXTENSION_VERSION"
    value = "~1"
  },
  {
    name  = "FUNCTIONS_WORKER_RUNTIME"
    value = "node"
  },
  {
    name  = "MAIL_FROM_DEFAULT"
    value = "IO - l'app dei servizi pubblici <no-reply@io.italia.it>"
  },
  {
    name  = "MESSAGE_CONTAINER_NAME"
    value = "message-content"
  },
  {
    name  = "PUBLIC_API_URL"
    value = "https://api.cd.italia.it/"
  },
  {
    name  = "SCM_USE_FUNCPACK_BUILD"
    value = 1
  },
  {
    name  = "WEBSITE_HTTPLOGGING_RETENTION_DAYS"
    value = 30
  },
  {
    name  = "WEBSITE_NODE_DEFAULT_VERSION"
    value = "6.11.2"
  }
]

functionapp_settings_secrets   = [
  {
    name        = "MAILUP_USERNAME"
    vault_alias = "fn101MailupUsername"
  },
  {
    name        = "MAILUP_SECRET"
    vault_alias = "fn101MailupSecret"
  },
  {
    name        = "PUBLIC_API_KEY"
    vault_alias = "fn101PublicApiKey"
  },
  {
    name        = "APPINSIGHTS_INSTRUMENTATIONKEY"
    vault_alias = "fn101AppInsightsInstrumentationKey"
  },
  {
    name        = "QueueStorageConnection"
    vault_alias = "fn101QueueStorageConnection"
  },
  {
    name        = "WEBHOOK_CHANNEL_URL"
    vault_alias = "fn101WebhookChannelUrl"
  }
]

functionapp_connection_strings = [
  {
    name        = "COSMOSDB_KEY"
    vault_alias = "fn101CosmosdbKey"
  },
  {
    name        = "COSMOSDB_URI"
    vault_alias = "fn101CosmosdbUri"
  }
]
