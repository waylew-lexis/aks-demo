
output "kube_config" {
  value       = module.aks.kube_config
}

output "kubelet_identity" {
  value = module.aks.kubelet_identity
}

output "aks_login" {
  value = "az aks get-credentials --name ${module.aks.cluster_name} --resource-group ${module.rg.name}"
}
