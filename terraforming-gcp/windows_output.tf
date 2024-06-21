output "windows_private_ip" {
  value       = var.windows_count > 0 ? module.windows[0].windows_private_ip : null
  description = "The private ip address for the DDVE Instance"
}

output "windows_instance_id" {
  value       = var.windows_count > 0 ? module.windows[0].windows_instance_id : null
  description = "The instance id (initial password) for the DDVE Instance"
  sensitive   = true
}
output "windows_ssh_private_key" {
  sensitive   = true
  value       = var.windows_count > 0 ? module.windows[0].ssh_private_key : null
  description = "The ssh private key for the DDVE Instance"
}


output "windows_ssh_public_key" {
  value       = var.windows_count > 0 ? module.windows[0].ssh_public_key : null
  sensitive   = true
  description = "The ssh public key for the DDVE Instance"
}
