variable "environment" {}
variable "resource_group_name" {}
variable "location" {}
variable "vnet_name" {}
variable "vnet_address_prefix" {}
variable "subnets" {
  type = map(object({
    name             = string
    address_prefixes = string
  }))
}

