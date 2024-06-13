variable "environment" {
  description = "The environment to deploy (dev or prod)"
  type        = string
  default     = "dev"
}

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

locals {
  cms_subnet_name        = var.environment == "prod" ? "prod-cms-subnet" : "dev-cms-subnet"
  backend_subnet_name    = var.environment == "prod" ? "prod-backend-subnet" : "dev-backend-subnet"
  frontend_subnet_name   = var.environment == "prod" ? "prod-frontend-subnet" : "dev-frontend-subnet"
  cms_vm_name            = var.environment == "prod" ? "prod-cms-vm" : "dev-cms-vm"
  backend_vm_name        = var.environment == "prod" ? "prod-backend-vm" : "dev-backend-vm"
  frontend_vm_name       = var.environment == "prod" ? "prod-frontend-vm" : "dev-frontend-vm"
  cms_public_ip_name     = var.environment == "prod" ? "prod-cms-public-ip" : "dev-cms-public-ip"
  backend_public_ip_name = var.environment == "prod" ? "prod-backend-public-ip" : "dev-backend-public-ip"
  frontend_public_ip_name= var.environment == "prod" ? "prod-frontend-public-ip" : "dev-frontend-public-ip"
}

resource "azurerm_virtual_network" "main" {
  name                = var.environment == "prod" ? "prod-main-vnet" : "dev-main-vnet"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "cms_subnet" {
  name                 = local.cms_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "backend_subnet" {
  name                 = local.backend_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "frontend_subnet" {
  name                 = local.frontend_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.3.0/24"]
}

module "cms_compute" {
  source              = "../modules/cms_compute"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = azurerm_subnet.cms_subnet.id
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  vm_name             = local.cms_vm_name
  public_ip_name      = local.cms_public_ip_name
}

module "backend_compute" {
  source              = "../modules/backend_compute"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = azurerm_subnet.backend_subnet.id
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  vm_name             = local.backend_vm_name
  public_ip_name      = local.backend_public_ip_name
}

module "frontend_compute" {
  source              = "../modules/frontend_compute"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = azurerm_subnet.frontend_subnet.id
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  vm_name             = local.frontend_vm_name
  public_ip_name      = local.frontend_public_ip_name
}
