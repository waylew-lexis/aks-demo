resource "azurerm_log_analytics_workspace" "oms" {
  name                = "${var.name_prefix}-law"
  location            = module.rg.location
  resource_group_name = module.rg.name
  retention_in_days   = 30
}

resource "azurerm_log_analytics_solution" "oms" {
  solution_name = "ContainerInsights"
  #solution_name         = "Containers"
  location              = module.rg.location
  resource_group_name   = module.rg.name
  workspace_resource_id = azurerm_log_analytics_workspace.oms.id
  workspace_name        = azurerm_log_analytics_workspace.oms.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}

