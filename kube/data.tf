data "azurerm_kubernetes_cluster" "cluster" {
  name                = "app-contoso-sandbox-eastus2"
  resource_group_name = "waylew-aks-cluster"
}
