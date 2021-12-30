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

data "azurerm_virtual_network" "vnet" {
  name                = "waylew-aks-${local.environment}-eastus2-vnet"
  resource_group_name = "waylew-aks-network-${local.environment}"
}

data "azurerm_subnet" "aks_private" {
  name                 = "iaas-private"
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_virtual_network.vnet.resource_group_name
}

data "azurerm_subnet" "aks_public" {
  name                 = "iaas-public"
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_virtual_network.vnet.resource_group_name
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

