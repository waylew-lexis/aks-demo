module "service_mesh" {
  source = "github.com/Azure-Terraform/terraform-helm-linkerd.git?ref=main"

  # required values
  chart_version               = "2.10.1"
  ca_cert_expiration_hours    = 8760  # 1 year
  trust_anchor_validity_hours = 17520 # 2 years
  issuer_validity_hours       = 8760  # 1 year (must be shorter than the trusted anchor)

  # optional value for linkerd config (in this case, override the default 'clockSkewAllowance' of 20s (for example purposes))
  additional_yaml_config = yamlencode({ "identity" : { "issuer" : { "clockSkewAllowance" : "30s" } } })
  linkerd_helm_install_timeout_secs = "2000"
}
