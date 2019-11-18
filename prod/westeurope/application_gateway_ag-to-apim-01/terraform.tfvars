terragrunt = {
  dependencies {
    paths = [
      "../subnet_ag-frontend",
      "../subnet_apim",
      "../public_ip_ag-to-apim-01"
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

# Application gateway variables
application_gateway_name_suffix                               = "to-apim-01"
public_ip_address_name_suffix                                 = "ag-to-apim-01"
azurerm_application_gateway_backend_address_pool_ip_addresses = ["172.16.50.5"]
vnet_name_suffix                                              = "common"
subnet_name_suffix                                            = "ag-frontend"
