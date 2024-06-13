output "vm_id" {
  description = "The ID of the Virtual Machine"
  value       = azurerm_virtual_machine.vm.id
}

output "public_ip_address" {
  description = "The Public IP address of the Virtual Machine"
  value       = azurerm_public_ip.public_ip.ip_address
}
