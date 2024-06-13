variable "location" {
  default = "northcentralus"
}

variable "resource_group_name" {
  default = "QZNC-TLR-RG"
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
}

variable "admin_password" {
  description = "Admin password for the VM"
  type        = string
  sensitive   = true
}
