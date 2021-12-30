module "rg" {
  source       = "../modules/rg"
  environment  = local.environment
  location     = var.location
  product_name = var.name_prefix
  service_name = "network"
}

module "virtual_network" {
  source = "git::https://github.com/Azure-Terraform/terraform-azurerm-virtual-network.git?ref=v5.0.0"

  #naming_rules = module.metadata.naming_yaml

  resource_group_name = module.rg.name
  location            = module.rg.location
  #names               = module.metadata.names
  names = local.names
  tags  = local.default_tags

  address_space = ["10.1.0.0/22"]

  subnets = {
    iaas-private = {
      cidrs                   = ["10.1.0.0/24"]
      route_table_association = "aks"
      configure_nsg_rules     = false
      service_endpoints       = ["Microsoft.Storage", "Microsoft.ContainerRegistry"]
    }
    iaas-public = {
      cidrs                   = ["10.1.1.0/24"]
      route_table_association = "aks"
      configure_nsg_rules     = false
      service_endpoints       = ["Microsoft.Storage", "Microsoft.ContainerRegistry"]
    }
  }

  route_tables = {
    aks = {
      disable_bgp_route_propagation = true
      use_inline_routes             = false
      routes = {
        internet = {
          address_prefix = "0.0.0.0/0"
          next_hop_type  = "Internet"
        }
        local-vnet = {
          address_prefix = "10.1.0.0/22"
          next_hop_type  = "vnetlocal"
        }
      }
    }
  }
}
