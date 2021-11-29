output "fqdn" {
  description = "kubernetes managed cluster fqdn"
  value       = azurerm_kubernetes_cluster.cluster.id
}

output "kube_config" {
  description = "kubernetes config to be used by kubectl and other compatible tools"
  value       = azurerm_kubernetes_cluster.cluster.kube_admin_config.0
}

output "kubelet_identity" {
  description = "kubelet identity information"
  value       = azurerm_kubernetes_cluster.cluster.kubelet_identity.0
}