
output "DDVE_PRIVATE_IP" {
  value       = [for ddve in module.ddve : ddve.ddve_private_ip_address]
  description = "The private ip address for the first DDVE Instance"
}

output "ddve_private_ip" {
  value       = [for ddve in module.ddve : ddve.ddve_private_ip_address]
  description = "The private ip addresses for the DDVE Instances"
}
output "DDVE_PUBLIC_FQDN" {
  sensitive   = false
  value       = [for ddve in module.ddve : ddve.ddve_private_ip_address]
  description = "we will use the Private IP as FQDN if no public is registered, so api calls can work"
}

output "DDVE_SSH_PRIVATE_KEY" {
  sensitive   = true
  value       = [for ddve in module.ddve : ddve.ssh_private_key]
  description = "The ssh private key for the DDVE Instance"
}
output "ddve_ssh_private_key" {
  sensitive   = true
  value       = [for ddve in module.ddve : ddve.ssh_private_key]
  description = "The ssh private key´s for the DDVE Instances"
}

output "DDVE_SSH_PUBLIC_KEY" {
  value       = [for ddve in module.ddve : ddve.ssh_public_key]
  sensitive   = true
  description = "The ssh public key for the DDVE Instance"
}

output "ddve_ssh_public_key" {
  value       = [for ddve in module.ddve : ddve.ssh_public_key]
  sensitive   = true
  description = "The ssh public keys for the DDVE Instances"
}
#output "ddve_private_fqdn" {
#  sensitive   = false
#  value       = var.ddve_count > 0 ? module.ddve[0].private_fqdn ]
#  description = "the private FQDN of the first DDVE"
#}
#output "DDVE_PRIVATE_FQDN" {
#  sensitive   = false
#  value       = [ for ddve in  module.ddve : ddve.private_fqdn ]
#  description = "the private FQDN of the DDVEs"#
#}

#output "ddve_public_fqdn" {
#  sensitive   = false
##  value       = var.ddve_count > 0 && var.ddve_public_ip ? module.ddve[0].private_fqdn : module.ddve[0].ddve_private_ip_address
#  description = "the private FQDN of the DDVE´s"
#}
#output "DDVE_PUBLIC_FQDN" {
#  sensitive   = false
#  value       = var.ddve_count > 0 && var.ddve_public_ip ? module.ddve[*].public_fqdn : var.ddve_count > 0 && !var.ddve_public_ip ? module.ddve[*].ddve_private_ip_address : null
#  description = "we will use the Private IP as FQDN if no public is registered, so api calls can work"
#}

output "DDVE_PASSWORD" {
  sensitive = true
  value     = [for ddve in module.ddve : var.ddve_initial_password]
}

output "DDVE_ATOS_STORAGE_ACCOUNT" {
  sensitive = true
  value     = [for ddve in module.ddve : ddve.atos_account]
}
output "DDVE_ATOS_CONTAINER" {
  sensitive = true
  value     = [for ddve in module.ddve : ddve.atos_container]
}

output "ddve_atos_storageaccount" {
  sensitive = true
  value     = [for ddve in module.ddve : ddve.atos_account]
}
output "ddve_atos_container" {
  sensitive = true
  value     = [for ddve in module.ddve : ddve.atos_container]
}
