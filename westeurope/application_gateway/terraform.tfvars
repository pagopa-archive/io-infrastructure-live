terragrunt = {
  dependencies {
    paths = [
      "../api_management",
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_application_gateway"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# application gateway variables
azurerm_application_gateway_sku_name                          = "WAF_v2"
azurerm_application_gateway_sku_tier                          = "WAF_v2"
azurerm_application_gateway_backend_address_pool_ip_addresses = ["172.16.50.5"]
azurerm_application_gateway_waf_configuration_firewall_mode   = "Detection"

# Azure key vault certificate variables
azurerm_key_vault_certificate_certificate_policy_x509_certificate_properties_subject = "CN=api.dev.io.italia.it"
