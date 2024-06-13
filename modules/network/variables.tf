variable "vnet_name" {
  description = "Name of the virtual network"
}

variable "address_space" {
  description = "Address space for the virtual network"
}

variable "location" {
  description = "Location for resources"
}

variable "resource_group_name" {
  description = "Name of the resource group"
}

variable "subnet_name" {
  description = "Name of the subnet"
}

variable "subnet_address_prefixes" {
  description = "Address prefixes for the subnet"
}

variable "nsg_name" {
  description = "Name of the network security group"
}
