terragrunt = {
  dependencies {
    paths = [
      "../service_principal_k8s-01-aad-server"
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_service_principal"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Service Principal module variables
app_name                                     = "k8s-01-aad-client"
app_name_k8s_aad_server                      = "k8s-01-aad-server"
app_type                                     = "k8s_aad_client"
azurerm_role_assignment_role_definition_name = "Contributor"
azurerm_key_vault_secret_name                = "k8s-01-aad-client-sp-secret"
