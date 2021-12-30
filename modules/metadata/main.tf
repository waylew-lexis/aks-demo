module "subscription" {
  source = "github.com/Azure-Terraform/terraform-azurerm-subscription-data.git?ref=v1.0.0"
  subscription_id = var.subscription_id
}

module "naming" {
  source = "github.com/Azure-Terraform/example-naming-template.git?ref=v1.0.0"
}

module "metadata" {
  source = "github.com/Azure-Terraform/terraform-azurerm-metadata.git?ref=v1.5.0"

  naming_rules = module.naming.yaml

  market              = "us"
  project             = "aks-demo"
  location            = var.location
  environment         = var.environment
  product_name        = var.product_name
  business_unit       = var.business_unit
  product_group       = var.product_group
  subscription_id     = module.subscription.output.subscription_id
  subscription_type   = var.subscription_type
  resource_group_type = "app"
}
