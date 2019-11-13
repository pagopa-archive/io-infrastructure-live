terragrunt = {
  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azuread_group"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Azure AD group module variables
group_name_suffix                 = "k8s-admins"
group_members_user_principal_name = [
  "andrea_teamdigitale.governo.it#EXT#@ttdio.onmicrosoft.com",
  "danilo.spinelli_agid.gov.it#EXT#@ttdio.onmicrosoft.com",
  "federico_teamdigitale.governo.it#EXT#@ttdio.onmicrosoft.com",
  "francescopersico_gmail.com#EXT#@ttdio.onmicrosoft.com",
  "l.pinna_beetobit.com#EXT#@ttdio.onmicrosoft.com",
  "lucaprete_teamdigitale.governo.it#EXT#@ttdio.onmicrosoft.com",
  "matteoboschi_teamdigitale.governo.it#EXT#@ttdio.onmicrosoft.com",
  "mirko_teamdigitale.governo.it#EXT#@ttdio.onmicrosoft.com",
  "r.chessa_beetobit.com#EXT#@ttdio.onmicrosoft.com",
  "rsetti_gmail.com#EXT#@ttdio.onmicrosoft.com"
]
