
locals {
  location = "useast2"
}

terraform {

  after_hook "init" {
    commands = ["init"]
    execute  = ["bash", "../scripts/tf-setup.sh"]
  }

  extra_arguments "common_vars" {
    commands = get_terraform_commands_that_need_vars()
    arguments = [
      "-var-file=./vars/dev.tfvars"
    ]
  }
}

generate "backend" {
  path = "terraform.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  required_version = ">= 1.1.0"
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "lexis-test"
    workspaces {
     prefix = "waylew-aks-${path_relative_to_include()}-"
    }
}
}
EOF
}

generate "providers" {
  path = "providers.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "azurerm" {
  storage_use_azuread = true
  subscription_id     = var.subscription_id
  features {}
}
EOF
}

generate "common" {
  path = "common.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
locals {
  environment = terraform.workspace
  default_tags = {
     contact = "wlewalski@lexisnexisrisk.com"
     environment = terraform.workspace
     location = var.location
     terraform = true
  }
}
EOF
}
