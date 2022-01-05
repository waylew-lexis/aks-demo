module "aks" {
  source = "git::https://github.com/LexisNexis-RBA/terraform-azurerm-aks?ref=v1.0.0-beta.5"

  cluster_name        = "${var.name_prefix}-${local.environment}"
  location            = module.rg.location
  tags                = module.rg.tags
  resource_group_name = module.rg.name

  ingress_node_pool = true

  node_pools = [
    {
      name         = "workers"
      single_vmss  = false
      public       = false
      node_type    = "x64-gp-v1"
      node_size    = "medium"
      min_capacity = 1
      max_capacity = 3
      labels = {
        "lnrs.io/tier" = "standard"
      }
      tags = {}
    }
  ]

  virtual_network = data.terraform_remote_state.vnet.outputs.aks_vnet

  core_services_config = {
    alertmanager = {
      smtp_host = "wayne.lewalski@lexisnexis.net"
      smtp_from = "wayne.lewalski@lexisnexis.net"
    }
    cert_manager = {
      dns_zones = {
        "infrastructure-sandbox.us.lnrisk.io" = "rg-iog-sandbox-eastus2-lnriskio"
      }
      azure_environment       = "AzurePublicCloud"
      letsencrypt_environment = "staging"
      letsencrypt_email       = "wayne.lewalski@lexisnexis.net"
    }
  }

  azuread_clusterrole_map = {
    cluster_admin_users = {
      admins = data.azuread_user.admin_user.object_id
    }
    standard_view_users = {}
    cluster_view_users  = {}
    standard_view_groups = {
      admins = data.azuread_group.admin_group.object_id
    }
  }
}

