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
  "lucaprete_teamdigitale.governo.it#EXT#@ttdio.onmicrosoft.com"
]
