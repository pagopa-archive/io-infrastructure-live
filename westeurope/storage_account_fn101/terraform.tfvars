terragrunt = {
  dependencies {
    paths = [
      "../resource_group",
      "../vnet_common",
      "../subnet_functions",
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_storage_account"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Storage account module related variables
storage_account_name = "fn101"

azurerm_storage_account_account_tier = "Standard"

azurerm_storage_account_account_replication_type = "LRS"

allowed_subnets = [
  {
    vnet   = "io-dev-vnet-common"
    subnet = "io-dev-subnet-functions"
  },
]
