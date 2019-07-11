terragrunt = {
  dependencies {
    paths = [
      "../dns_zone_public_io_italia_it",
      "../public_ip_k8s_01"
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_dns_zone_records_k8s"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Azure DNS zone records module variables
dns_zone_suffix                = "io.italia.it"

kubernetes_public_ip_name      = "k8s-01"
kubernetes_resource_group_name = "MC_io-dev-rg_io-dev-aks-k8s-01_westeurope"
aks_cluster_name               = "k8s-01"
kubernetes_cname_records       = []

vpn_dev_host_name              = "vpn-srv-01.dev"
vpn_dev_public_ip_name         = "vpn-01"

developers_cname_records       = [
  {
    name  = "developer"
    value = "teamdigitale.github.io"
  },
  {
    name  = "dev-portal"
    value = "dev-portal-prod.azurewebsites.net"
  }
]

mailgun_cname_record           = {
  name  = "email"
  value = "mailgun.org"
}

mailgun_mx_record              = {
  name    = "@"
  value_a = "mxa.mailgun.org"
  value_b = "mxb.mailgun.org"
}

mailup_txt_records             = [
  {
    name  = "@"
    value = "v=spf1 include:musvc.com ~all"
  },
  {
    name  = "k1._domainkey"
    value = "k=rsa;p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDHLc6vUlOTMTdnebFcf4HDCtBZKOnVuHAmmvu0IWccGrSsJoKuiOEPTVKbCeW7ELX24v2YR1dRyDzqA7lxjp3NBurlOX0CzZlrGD2KAiz9OiCYK61ZlC9lpCr9jjIBO1Ax55jha6kM7w8zCQy2m6SjexulicEzWcxQb0djvWTowwIDAQAB"
  }
]

mailup_cname_records           = [
  {
    name  = "ml01._domainkey"
    value = "ml01.dkim.musvc.com."
  },
  {
    name  = "ml02._domainkey"
    value = "ml02.dkim.musvc.com."
  }
]
