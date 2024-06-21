locals {
  windows_name = "${var.windows_name}-${var.windows_instance}"

}
resource "google_compute_instance" "windows" {
  zone         = var.instance_zone
  tags         = concat(
    var.target_tags,
    [local.windows_name]
  )
  labels = merge(
    var.labels,
    {
      "environment" = var.environment
    },
  )
  boot_disk {
    auto_delete = true
    device_name = "windows-1"

    initialize_params {
      image = "projects/windows-cloud/global/images/windows-server-2022-dc-v20240612"
      type  = "pd-balanced"
      size = 50
    }
    mode = "READ_WRITE"
  }

#  enable_display      = true
  machine_type = "n2-standard-2"
  name         = "windows"
  network_interface {
    network    = var.instance_network_name
    subnetwork = var.instance_subnetwork_name
  }
  metadata = {
    ssh-keys = "cloudadmin:${tls_private_key.windows.public_key_openssh}"
  }


  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
    provisioning_model  = "STANDARD"
  }
 deletion_protection = var.deletion_protection
}


resource "tls_private_key" "windows" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

