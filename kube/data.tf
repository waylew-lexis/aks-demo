data "azurerm_kubernetes_cluster" "cluster" {
  name                = "waylew-cluster"
  resource_group_name = "waylew-aks-cluster"
}