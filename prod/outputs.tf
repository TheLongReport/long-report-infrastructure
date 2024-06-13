output "frontend_public_ip" {
  value = module.frontend_compute.public_ip_address
}

output "backend_public_ip" {
  value = module.backend_compute.public_ip_address
}

output "cms_public_ip" {
  value = module.cms_compute.public_ip_address
}
