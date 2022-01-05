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
  names                = local.names
  tags                 = local.default_tags
  enforce_subnet_names = false

  address_space = ["10.1.0.0/22"]

  aks_subnets = {
    demo = {
      private = {
        cidrs             = ["10.1.3.0/25"]
        service_endpoints = ["Microsoft.Storage", "Microsoft.ContainerRegistry"]
      }
      public = {
        cidrs             = ["10.1.3.128/25"]
        service_endpoints = ["Microsoft.Storage", "Microsoft.ContainerRegistry"]
      }
      route_table = {
        disable_bgp_route_propagation = true
        routes = {
          internet = {
            address_prefix = "0.0.0.0/0"
            next_hop_type  = "Internet"
          }
          local-vnet-10-1-0-0-21 = {
            address_prefix = "10.1.0.0/21"
            next_hop_type  = "vnetlocal"
          }
        }
      }
    }
  }
}
