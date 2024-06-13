provider "azurerm" {
  features {}
  skip_provider_registration = true
}

module "network" {
  source = "../modules/network"

  vnet_name               = "DevLongReportVNet"
  address_space           = ["10.0.0.0/16"]
  location                = var.location
  resource_group_name     = var.resource_group_name
  subnet_name             = "DevLongReportSubnet"
  subnet_address_prefixes = ["10.0.1.0/24"]
  nsg_name                = "DevLongReportNSG"
}

module "frontend_compute" {
  source = "../modules/frontend_compute"

  nic_name            = "DevLongReportFrontendNIC"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = module.network.subnet_id
  public_ip_name      = "DevLongReportFrontendPublicIP"
  vm_name             = "DevLongReportFrontendVM"
  vm_size             = "Standard_B2s"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
}

module "backend_compute" {
  source = "../modules/backend_compute"

  nic_name            = "DevLongReportBackendNIC"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = module.network.subnet_id
  public_ip_name      = "DevLongReportBackendPublicIP"
  vm_name             = "DevLongReportBackendVM"
  vm_size             = "Standard_B2s"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
}

module "cms_compute" {
  source = "../modules/cms_compute"

  nic_name            = "DevLongReportCMSNIC"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = module.network.subnet_id
  public_ip_name      = "DevLongReportCMSPublicIP"
  vm_name             = "DevLongReportCMSVM"
  vm_size             = "Standard_B2s"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
}
