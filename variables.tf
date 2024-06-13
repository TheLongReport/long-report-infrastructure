variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
}

variable "location" {
  description = "Azure location"
  type        = string
}

variable "admin_username" {
  description = "Admin username"
  type        = string
}

variable "admin_password" {
  description = "Admin password"
  type        = string
  sensitive   = true
}

variable "environment" {
  description = "The environment to deploy (dev or prod)"
  type        = string
  default     = "dev"
}
