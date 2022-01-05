data "azuread_user" "admin_user" {
  #mail_nickname = "lewawa01@risk.regn.net"
  user_principal_name = "lewawa01_risk.regn.net#EXT#@RBAHosting.onmicrosoft.com"
}

data "azuread_group" "admin_group" {
  display_name     = "ris-azr-group-us-infrastructure-dev-owner"
  security_enabled = true
}

data "http" "my_ip" {
  url = "https://ifconfig.me"
}

data "terraform_remote_state" "vnet" {
  backend = "remote"
  config = {
    organization = "lexis-test"
    workspaces = {
      name = "waylew-aks-network-${local.environment}"
    }
  }
}

