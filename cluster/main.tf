
resource "azurerm_kubernetes_cluster" "cluster" {
  name                = "${var.name_prefix}-${local.environment}"
  dns_prefix          = "waylew-cluster"
  location            = module.rg.location
  resource_group_name = module.rg.name
  kubernetes_version  = "1.21.2"
  sku_tier            = "Free"

  addon_profile {
    aci_connector_linux {
      enabled     = true
      subnet_name = azurerm_subnet.aci_subnet.name
    }

    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = azurerm_log_analytics_workspace.oms.id
    }

    open_service_mesh {
      enabled = false
    }

    azure_policy {
      enabled = true
    }
  }

  role_based_access_control {
    enabled = true
    azure_active_directory {
      admin_group_object_ids = [data.azuread_group.admin_group.object_id]
      managed                = true
      #azure_rbac_enabled     = true
    }
  }

  linux_profile {
    admin_username = "azureuser"
    ssh_key {
      key_data = module.ssh-key.public_ssh_key
    }
  }

  default_node_pool {
    name                = "default"
    vm_size             = "Standard_DS2_v2"
    vnet_subnet_id      = data.terraform_remote_state.vnet.outputs.private_subnet_id
    enable_auto_scaling = true
    os_disk_size_gb     = 30
    node_count          = 1
    min_count = 1
    max_count = 3

    availability_zones = [
      "1",
      "2",
      "3"
    ]
  }

  network_profile {
    network_plugin    = "azure"
    network_policy    = "azure"
    load_balancer_sku = "Standard"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = local.default_tags
}


resource "azurerm_subnet" "aci_subnet" {
  name                 = "${var.name_prefix}-aci"
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_virtual_network.vnet.resource_group_name
  address_prefixes     = ["10.1.2.0/24"]

  delegation {
    name = "aciDelegation"
    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

