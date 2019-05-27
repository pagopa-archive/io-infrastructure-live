terragrunt = {
  # Configure root level variables that all resources can inherit
  remote_state {
    backend = "azurerm"

    config {
      resource_group_name  = "${get_env("RG_NAME", "io-infra")}"
      storage_account_name = "${get_env("TERRAFORM_STORAGE_ACCOUNT_NAME", "iotf")}"
      container_name       = "${get_env("TERRAFORM_CONTAINER_NAME", "io-tf")}"
      key = "development/${path_relative_to_include()}/terraform.tfstate"
    }
  }

  # For each module include common vars.tfvars files along the path
  terraform {
    extra_arguments "-var-file" {
      commands = ["${get_terraform_commands_that_need_vars()}"]

      optional_var_files = [
        "${get_parent_tfvars_dir()}/vars.tfvars",
        "${get_tfvars_dir()}/${find_in_parent_folders("vars.tfvars", "ignore")}"
      ]
    }
  }
}
