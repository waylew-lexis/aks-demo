data "azuread_user" "admin" {
  #mail_nickname = "lewawa01@risk.regn.net"
  user_principal_name = "lewawa01_risk.regn.net#EXT#@RBAHosting.onmicrosoft.com"
}

data "http" "my_ip" {
  url = "https://ifconfig.me"
}

data "azurerm_subscription" "current" {
}

data "azurerm_virtual_network" "vnet" {
  name                = "waylew-aks-vnet"
  resource_group_name = "waylew-aks-network"
}

data "azurerm_subnet" "aks" {
  name                 = "aks"
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = "waylew-aks-network"
}

