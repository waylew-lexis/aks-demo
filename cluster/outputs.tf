output "fqdn" {
  description = "kubernetes managed cluster fqdn"
  value       = azurerm_kubernetes_cluster.cluster.fqdn
}

output "kube_config" {
  description = "kubernetes config to be used by kubectl and other compatible tools"
  #value       = module.aks_cluster.kube_config
  value = azurerm_kubernetes_cluster.cluster.kube_config
}

output "kubelet_identity" {
  description = "kubelet identity information"
  #value       = module.aks_cluster.kubelet_identity
  value = azurerm_kubernetes_cluster.cluster.kubelet_identity
}

output "aks_login" {
  #value = "az aks get-credentials --name ${module.aks_cluster.name} --resource-group ${azurerm_resource_group.rg.name}"
  value = "az aks get-credentials --name ${azurerm_kubernetes_cluster.cluster.name} --resource-group ${module.rg.name}"
}
