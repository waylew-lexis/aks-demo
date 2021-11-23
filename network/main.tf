resource "azurerm_resource_group" "main" {
  location = "eastus2"
  name     = "waylew-aks-network"
}

resource "azurerm_virtual_network" "vnet" {
  address_space       = ["10.0.0.0/8"]
  location            = azurerm_resource_group.main.location
  name                = "waylew-aks-vnet"
  resource_group_name = azurerm_resource_group.main.name
}

module "subnet_aks" {
  source = "../modules/subnet"
  address_prefixes = ["10.240.0.0/16"]
  name = "aks"
  resource_group_name = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.vnet.name
}

module "subnet_aci" {
  source = "../modules/subnet"
  address_prefixes = ["10.241.0.0/16"]
  name = "virtual-node-aci"
  resource_group_name = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.vnet.name
}