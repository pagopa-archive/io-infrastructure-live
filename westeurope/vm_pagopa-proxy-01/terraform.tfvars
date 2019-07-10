terragrunt = {
  dependencies {
    paths = [
      "../subnet_k8s-01",
      "../dns_zone_private_common",
      "../storage_account_vms_boot_diagnostics"
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_virtual_machine"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Base VM module variables
vnet_name                                                     = "common"
resource_group_name                                           = "io-dev-rg"
subnet_name                                                   = "k8s-01"

storage_account_resource_group_name                           = "io-dev-rg"
storage_account_name                                          = "bootdiagnostics"

vm_name                                                       = "pagopa-proxy-01"
custom_image_name                                             = "base-linux-centos-0.1"
azurerm_network_interface_ip_configuration_private_ip_address = "172.16.0.254"
azurerm_virtual_machine_size                                  = "Standard_A2_v2"
azurerm_virtual_machine_storage_os_disk_type                  = "Standard_LRS"
azurerm_key_vault_secret_ssh_public_key_name                  = "terraformsshkeypub"

public_ip                                                     = true

dns_private_zone_suffix                                       = "io.internal"

azurerm_network_security_rules                                = []
