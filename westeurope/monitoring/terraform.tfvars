# For more info look at the README.md file of the module.

terragrunt = {
  terraform {
    source = "git::git@github.com:teamdigitale/io-infrastructure-modules.git//azurerm_monitor_action_group"
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

#  monitoring action group module variables
monitor_ag_name = "CriticalAlertses"
monitor_ag_short_name = "CriticalAlerts"
email_receiver_unique_name = "admins"
email_receiver_email = "lprete@teamdigitale.it"
