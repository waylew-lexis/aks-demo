output "workspace" {
  value = terraform.workspace
}

output "vnet_id" {
  value = module.virtual_network.vnet.id
}

output "private_subnet_id" {
  value = module.virtual_network.subnets["iaas-private"].id
}

output "public_subnet_id" {
  value = module.virtual_network.subnets["iaas-public"].id
}
