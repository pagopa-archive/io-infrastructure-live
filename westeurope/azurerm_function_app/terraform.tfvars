# Creates a Kubernetes Cluster through AKS using the Kubenet CNI.
# For more info look at the README.md file of the module.

terragrunt = {
  dependencies {
    paths = [
      "../subnet_k8s_01",
      "../cosmosdb_sql_database",
      "../subnet_functions",
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

plan_name = "premium-plan"

storage_account_name = "functions"

connectionStrings = [
  {
    Name  = "COSMOSDB_KEY"
    Alias = "cosmosdb-key"
  },
  {
    Name  = "COSMOSDB_URI"
    Alias = "cosmosdb-uri"
  },
]

appSettings = [
  {
    # {
    #   Name  = "AzureWebJobsStorage"
    #   Alias = "azurewebjobsstorage"
    # },
    Name = "AzureWebJobsSecretStorageType"

    Alias = "azurewebjobssecretstoragetype"
  },
  {
    Name  = "MAIL_FROM_DEFAULT"
    Alias = "mail-from-default"
  },
  {
    Name  = "MAILUP_SECRET"
    Alias = "mailup-secret"
  },
  {
    Name  = "MAILUP_USERNAME"
    Alias = "mailup-username"
  },
  {
    Name  = "MESSAGE_CONTAINER_NAME"
    Alias = "message-container-name"
  },
  {
    Name  = "PUBLIC_API_KEY"
    Alias = "public-api-key"
  },
  {
    Name  = "PUBLIC_API_URL"
    Alias = "public-api-url"
  },
  {
    Name  = "COSMOSDB_NAME"
    Alias = "cosmosdb-name"
  },
  {
    Name  = "APPINSIGHTS_INSTRUMENTATIONKEY"
    Alias = "appinsights-instrumentationkey"
  },
  {
    Name  = "QueueStorageConnection"
    Alias = "queuestorageconnection"
  },
  {
    Name  = "WEBHOOK_CHANNEL_URL"
    Alias = "webhook-channel-url"
  },
  {
    Name  = "WEBSITE_HTTPLOGGING_RETENTION_DAYS"
    Alias = "website-httplogging-retention-days"
  },
  {
    Name  = "FUNCTION_APP_EDIT_MODE"
    Alias = "function-app-edit-mode"
  },
  {
    Name  = "SCM_USE_FUNCPACK_BUILD"
    Alias = "scm-use-funcpack-build"
  },
  {
    Name  = "DIAGNOSTICS_AZUREBLOBRETENTIONINDAYS"
    Alias = "diagnostics-azureblobretentionindays"
  },
  {
    Name  = "FUNCTIONS_EXTENSION_VERSION"
    Alias = "functions-extension-version"
  },
  {
    Name  = "FUNCTIONS_WORKER_RUNTIME"
    Alias = "functions-worker-runtime"
  },
  {
    Name  = "WEBSITE_NODE_DEFAULT_VERSION"
    Alias = "website-node-default-version"
  },
]
