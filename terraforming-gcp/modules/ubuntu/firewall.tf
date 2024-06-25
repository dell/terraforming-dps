resource "google_compute_firewall" "ubuntu-ingress" {
  name          = "${local.ubuntu_name}-ingress"
  network       = var.instance_network_name
  source_ranges = ["0.0.0.0/0"]
  direction     = "INGRESS"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "8080", "443", "9000-9001", "9090", "7543", "7937-7954"]
  }
  target_tags = concat(
    var.target_tags,
    [local.ubuntu_name],
  )
  depends_on = [google_compute_instance.ubuntu]
}
resource "google_compute_firewall" "ubuntu-egress" {
  name          = "${local.ubuntu_name}-egress"
  network       = var.instance_network_name
  source_ranges = ["0.0.0.0/0"]
  direction     = "EGRESS"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["389", "443", "636", "3009", "5989", "7000", "25", "587", "143", "993", "2702", "111", "2049", "2052", "9443", "9090", "9613", "30095", "14251"]
  }
  allow {
    protocol = "udp"
    ports    = ["123", "162", "514"]
  }
  source_tags = var.source_tags
  target_tags = concat(
    var.target_tags,
    [local.ubuntu_name],
  )
  depends_on = [google_compute_instance.ubuntu]
}
