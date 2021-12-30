locals {
  names = {
    product_name        = var.name_prefix
    product_group       = var.name_prefix
    subscription_type   = local.environment
    location            = var.location
    resource_group_type = "app"
  }
}
