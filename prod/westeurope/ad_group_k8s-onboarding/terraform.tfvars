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
group_name_suffix                 = "k8s-onboarding"
group_members_user_principal_name = [
  "danilo.spinelli_agid.gov.it#EXT#@ttdio.onmicrosoft.com",
  "alexgpeppe84_hotmail.it#EXT#@ttdio.onmicrosoft.com",
  "davide.aliti_it.ibm.com#EXT#@ttdio.onmicrosoft.com"
]
