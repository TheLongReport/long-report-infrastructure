variable "nic_name" {
  description = "Name of the network interface"
}

variable "location" {
  description = "Location of the resources"
}

variable "resource_group_name" {
  description = "Resource group name"
}

variable "subnet_id" {
  description = "Subnet ID"
}

variable "public_ip_name" {
  description = "Public IP name"
}

variable "vm_name" {
  description = "Virtual machine name"
}

variable "vm_size" {
  description = "Size of the virtual machine"
}

variable "admin_username" {
  description = "Admin username for the VM"
}

variable "admin_password" {
  description = "Admin password for the VM"
}
