variable "environment" {
  description = ""
  type = string
}

variable "location" {
  description = ""
  type = string
}

variable "product_name" {
  description = ""
  type = string
}

variable "service_name" {
  description = ""
  type = string
}

variable "additional_tags" {
  description = ""
  type = map(string)
  default = {}
}
