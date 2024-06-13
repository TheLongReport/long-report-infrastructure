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

  environment         = "dev"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = module.network.subnet_id
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  vm_name             = "DevLongReportFrontendVM"
  public_ip_name      = "DevLongReportFrontendPublicIP"
  vm_size             = "Standard_B2s"
}

module "backend_compute" {
  source = "../modules/backend_compute"

  environment         = "dev"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = module.network.subnet_id
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  vm_name             = "DevLongReportBackendVM"
  public_ip_name      = "DevLongReportBackendPublicIP"
  vm_size             = "Standard_B2s"
}

module "cms_compute" {
  source = "../modules/cms_compute"

  environment         = "dev"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = module.network.subnet_id
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  vm_name             = "DevLongReportCMSVM"
  public_ip_name      = "DevLongReportCMSPublicIP"
  vm_size             = "Standard_B2s"
}
