provider "azurerm" {
  features {}
  skip_provider_registration = true
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
  source = "../modules/frontend_compute"

  environment         = "prod"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = module.network.subnet_id
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  vm_name             = "ProdLongReportFrontendVM"
  public_ip_name      = "ProdLongReportFrontendPublicIP"
  vm_size             = "Standard_B2s"
}

module "backend_compute" {
  source = "../modules/backend_compute"

  environment         = "prod"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = module.network.subnet_id
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  vm_name             = "ProdLongReportBackendVM"
  public_ip_name      = "ProdLongReportBackendPublicIP"
  vm_size             = "Standard_B2s"
}

module "cms_compute" {
  source = "../modules/cms_compute"

  environment         = "prod"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = module.network.subnet_id
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  vm_name             = "ProdLongReportCMSVM"
  public_ip_name      = "ProdLongReportCMSPublicIP"
  vm_size             = "Standard_B2s"
}
