provider "azurerm" {
  features {}
}

module "network" {
  source = "../modules/network"

  vnet_name               = "ProdLongReportVNet"
  address_space           = ["10.0.0.0/16"]
  location                = var.location
  resource_group_name     = var.resource_group_name
  subnet_name             = "ProdLongReportSubnet"
  subnet_address_prefixes = ["10.0.1.0/24"]
  nsg_name                = "ProdLongReportNSG"
}

module "frontend_compute" {
  source = "../modules/compute"

  nic_name            = "ProdLongReportFrontendNIC"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = module.network.subnet_id
  public_ip_name      = "ProdLongReportFrontendPublicIP"
  vm_name             = "ProdLongReportFrontendVM"
  vm_size             = "Standard_B2s"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
}

module "backend_compute" {
  source = "../modules/compute"

  nic_name            = "ProdLongReportBackendNIC"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = module.network.subnet_id
  public_ip_name      = "ProdLongReportBackendPublicIP"
  vm_name             = "ProdLongReportBackendVM"
  vm_size             = "Standard_B2s"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
}

module "cms_compute" {
  source = "../modules/compute"

  nic_name            = "ProdLongReportCMSNIC"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = module.network.subnet_id
  public_ip_name      = "ProdLongReportCMSPublicIP"
  vm_name             = "ProdLongReportCMSVM"
  vm_size             = "Standard_B2s"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
}
