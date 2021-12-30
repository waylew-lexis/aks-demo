resource "azurerm_role_assignment" "rbac_admin" {
  scope                = azurerm_kubernetes_cluster.cluster.id
  role_definition_name = "Azure Kubernetes Service Cluster Admin Role"
  principal_id         = data.azuread_user.admin_user.object_id
}

resource "azurerm_role_assignment" "aci" {
  scope                = azurerm_subnet.aci_subnet.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_kubernetes_cluster.cluster.identity.0.principal_id
}
