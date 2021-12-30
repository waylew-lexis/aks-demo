data "azurerm_kubernetes_cluster" "cluster" {
  name                = "waylew-aks-${local.environment}"
  resource_group_name = "waylew-aks-cluster-${local.environment}"
}
