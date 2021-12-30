variable "subscription_id" {
  type = string
}

variable "product_name" {
  type = string
}

variable "business_unit" {
  type = string
}

variable "product_group" {
  type = string
}

variable "location" {
  type = string
  default = "eastus2"
}

variable "environment" {
  type = string
  default = "sandbox"
}

variable "subscription_type" {
  type = string
  default = "dev"
}

