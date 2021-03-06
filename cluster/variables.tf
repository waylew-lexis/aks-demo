variable "acr_pull_access" {
  description = "map of ACR ids to allow AcrPull"
  type        = map(string)
  default     = {}
}

variable "subscription_id" {
  type = string
}

variable "location" {
  type    = string
  default = "eastus2"
}

variable "name_prefix" {
  type    = string
  default = "waylew-aks"
}


