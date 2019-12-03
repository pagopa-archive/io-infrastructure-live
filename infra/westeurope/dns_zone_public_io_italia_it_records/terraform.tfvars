terragrunt = {
  dependencies {
    paths = [
      "../dns_zone_public_io_italia_it"
    ]
  }

  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_dns_zone_records_io_italia_it"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Azure DNS zone records module variables
dns_zone_suffix                = "io.italia.it"

kubernetes_public_ip_name      = "agid-k8s-ip-test-k8s-01"
kubernetes_resource_group_name = "MC_agid-rg-test_agid-aks-k8s-01-test_westeurope"
aks_cluster_name_old           = "k8s.test"
kubernetes_cname_records_old   = []

kubernetes_cname_records       = [
  "api.pa-onboarding",
  "spid-testenv",
  "app-backend",
  "app-backend-rc",
  "pa-onboarding",
  "backend.developer",
  # TODO: enable once new infra is migrated
  # "developer"
]

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
