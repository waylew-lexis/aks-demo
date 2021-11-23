resource "azurerm_resource_group" "main" {
  location = "eastus2"
  name     = "waylew-aks-cluster"
}

module "ssh-key" {
  source         = "../modules/ssh-key"
}

resource "azurerm_kubernetes_cluster" "cluster" {
  dns_prefix          = "waylew-cluster-dns"
  location            = azurerm_resource_group.main.location
  name                = "waylew-cluster"
  resource_group_name = azurerm_resource_group.main.name
  kubernetes_version = "1.20.9"
  sku_tier            = "Free"

  addon_profile {
    aci_connector_linux {
      enabled     = true
      subnet_name = "virtual-node-aci"
    }

    oms_agent {
      enabled = true
      log_analytics_workspace_id = azurerm_log_analytics_workspace.oms.id
    }

    open_service_mesh {
      enabled = true
    }

    azure_policy {
      enabled = true
    }
  }

  role_based_access_control {
    enabled = true
    azure_active_directory {
      admin_group_object_ids = [data.azuread_user.admin.object_id]
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
    name           = "agentpool"
    vm_size        = "Standard_DS2_v2"
    vnet_subnet_id = data.azurerm_subnet.aks.id
    enable_auto_scaling = true
    node_count = 1
    min_count = 1
    max_count = 3

    availability_zones = [
      "1",
      "2",
      "3"
    ]
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
    load_balancer_sku = "Standard"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    contact = "wayne.lewalski@lexisnexisrisk.com"
  }
}