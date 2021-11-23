resource "azurerm_role_assignment" "rbac_admin" {
  scope                = azurerm_kubernetes_cluster.cluster.id
  role_definition_name = "Azure Kubernetes Service Cluster User Role"
  principal_id         = data.azuread_user.admin.object_id
}

resource "azurerm_role_assignment" "acr_pull" {
  for_each                         = var.acr_pull_access
  scope                            = each.value
  role_definition_name             = "AcrPull"
  principal_id                     = azurerm_kubernetes_cluster.cluster.kubelet_identity.0.object_id
  skip_service_principal_aad_check = true
}

