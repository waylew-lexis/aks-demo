resource "azurerm_resource_group" "this" {
  location = var.location
  name     = "${var.product_name}-${var.service_name}-${var.environment}"
  tags     = merge(local.default_tags, var.additional_tags)
}
