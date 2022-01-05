output "workspace" {
  value = local.environment
}

output "vnet_id" {
  value = module.virtual_network.vnet.id
}

output "aks_vnet" {
  value = module.virtual_network.aks["demo"]
}

