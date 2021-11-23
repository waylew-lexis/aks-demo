variable "acr_pull_access" {
  description = "map of ACR ids to allow AcrPull"
  type        = map(string)
  default     = {}
}