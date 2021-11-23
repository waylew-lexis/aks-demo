resource "azurerm_log_analytics_workspace" "oms" {
  name                = "waylew-aks-workspace"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "Free"
  retention_in_days   = 7
}

resource "azurerm_log_analytics_solution" "oms" {
  solution_name         = "ContainerInsights"
  location              = azurerm_resource_group.main.location
  resource_group_name   = azurerm_resource_group.main.name
  workspace_resource_id = azurerm_log_analytics_workspace.oms.id
  workspace_name        = azurerm_log_analytics_workspace.oms.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}


