output "ssh_public_key" {
  sensitive = true
  value     = tls_private_key.windows.public_key_openssh
}
output "ssh_private_key" {
  sensitive = true
  value     = tls_private_key.windows.private_key_pem
}
output "windows_private_ip" {
    value = google_compute_instance.windows.network_interface[0].network_ip
}

output "windows_instance_id" {
    value = google_compute_instance.windows.instance_id
}
