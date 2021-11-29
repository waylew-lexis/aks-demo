provider "kubernetes" {
  host = data.azurerm_kubernetes_cluster.cluster.kube_config.0.host
  #username               = azurerm_kubernetes_cluster.cluster.kube_config.username
  #password               = azurerm_kubernetes_cluster.cluster.kube_config.password
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_config.0.client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_config.0.cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host = data.azurerm_kubernetes_cluster.cluster.kube_config.0.host
    #username               = azurerm_kubernetes_cluster.cluster.kube_config.username
    #password               = azurerm_kubernetes_cluster.cluster.kube_config.password
    client_certificate     = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_config.0.client_certificate)
    client_key             = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_config.0.cluster_ca_certificate)
  }
}

provider "azurerm" {
  features {}
}