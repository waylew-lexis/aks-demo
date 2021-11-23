provider "kubernetes" {
  host                   = azurerm_kubernetes_cluster.cluster.kube_config.host
  #username               = azurerm_kubernetes_cluster.cluster.kube_config.username
  #password               = azurerm_kubernetes_cluster.cluster.kube_config.password
  client_certificate     = base64decode(azurerm_kubernetes_cluster.cluster.kube_config.client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.cluster.kube_config.client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.cluster.kube_config.cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = azurerm_kubernetes_cluster.cluster.kube_config.host
    #username               = azurerm_kubernetes_cluster.cluster.kube_config.username
    #password               = azurerm_kubernetes_cluster.cluster.kube_config.password
    client_certificate     = base64decode(azurerm_kubernetes_cluster.cluster.kube_config.client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.cluster.kube_config.client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.cluster.kube_config.cluster_ca_certificate)
  }
}