module "metadata" {
  source = "../modules/metadata"

  business_unit = "infra"
  environment = "sandbox"
  product_group = "waylew"
  product_name = "contoso"
  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "rg" {
  location = module.metadata.location
  name     = "waylew-aks-cluster"
  tags = module.metadata.tags
}

resource "azurerm_user_assigned_identity" "aks" {
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  name                = "waylew-aks-identity"
}

module "aks_cluster" {
  source = "github.com/Azure-Terraform/terraform-azurerm-kubernetes.git?ref=v4.2.1"

  location = module.metadata.location
  names    = module.metadata.names
  tags     = module.metadata.tags
  resource_group_name = azurerm_resource_group.rg.name
  identity_type          = "UserAssigned"
  network_plugin         = "kubenet"
  configure_network_role     = true
  default_node_pool = "system"
  enable_azure_policy = true
  log_analytics_workspace_id = azurerm_log_analytics_workspace.oms.id

  rbac = {
    enabled = true
    ad_integration = true
  }

  rbac_admin_object_ids = {
    admins = data.azuread_user.admin.object_id
  }

  user_assigned_identity = {
    id = azurerm_user_assigned_identity.aks.id
    principal_id = azurerm_user_assigned_identity.aks.principal_id
    client_id = azurerm_user_assigned_identity.aks.client_id
  }

  node_pools = {
    system = {
      vm_size    = "Standard_B2s"
      node_count = 1
      only_critical_addons_enabled = true
      subnet     = "private"
    }

    linuxweb = {
      vm_size             = "Standard_B2ms"
      enable_auto_scaling = true
      min_count           = 1
      max_count           = 3
      subnet              = "public"
    }
  }

  virtual_network = {
    subnets = {
      private = {
        id = data.azurerm_subnet.aks_private.id
      }
      public = {
        id = data.azurerm_subnet.aks_public.id
      }
    }

    route_table_id = data.azurerm_subnet.aks_private.route_table_id
  }
}


