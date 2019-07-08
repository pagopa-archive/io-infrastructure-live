# Variables hinerited by all underlying modules
resource_name_prefix                                 = "io"
environment                                          = "dev"
infra_resource_group_name                            = "io-infra"
ssh_public_key_path                                  = "~/.ssh/id_rsa.pub"
ssh_private_key_path                                 = "~/.ssh/id_rsa"
dns_record_ttl                                       = "300"
azurerm_key_vault_name                               = "io-dev-keyvault"
