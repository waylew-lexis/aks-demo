module "ssh-key" {
  source = "../modules/ssh-key"
}

module "rg" {
  source       = "../modules/rg"
  environment  = local.environment
  location     = var.location
  product_name = var.name_prefix
  service_name = "cluster"
}
