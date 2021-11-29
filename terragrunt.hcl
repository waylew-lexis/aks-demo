remote_state {
  backend = "remote"
  disable_init = true

  config = {
    hostname = "app.terraform.io"
    organization = "lexis-test"
  }
}

inputs = {
  location = "eastus2"
  resource_group_name = "testResourceGroup1-10"
}

generate "backend" {
  path = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
   terraform {
    backend "remote" {
    hostname = "app.terraform.io"
    organization = "lexis-test"
    workspaces {
     prefix = "my-aks-${path_relative_to_include()}-"
    }
  }
}
EOF
}

terraform {
  before_hook "init" {
    commands     = ["init"]
    execute      = ["echo", "before-hook"]
    run_on_error = true
  }

  after_hook "terragrunt-read-config" {
    commands = ["terragrunt-read-config"]
    execute = ["bash", "../scripts/tf-setup.sh"]
  }
}