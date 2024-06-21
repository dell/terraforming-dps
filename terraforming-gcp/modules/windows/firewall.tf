resource "google_compute_firewall" "windows-ingress" {
  name          = "${local.windows_name}-ingress"
  network       = var.instance_network_name
  source_ranges = ["0.0.0.0/0"]
  direction     = "INGRESS"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "3389", "5986","7000-7009","7012-7020"]
  }
  target_tags = concat(
    var.target_tags,
    [local.windows_name],
  )
  depends_on = [google_compute_instance.windows]
}
resource "google_compute_firewall" "windows-egress" {
  name          = "${local.windows_name}-egress"
  network       = var.instance_network_name
  source_ranges = ["0.0.0.0/0"]
  direction     = "EGRESS"

  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["22", "3389", "5986","7000-7009","7012-7020"]
  }
  source_tags = var.source_tags
  target_tags = concat(
    var.target_tags,
    [local.windows_name],
  )
  depends_on = [google_compute_instance.windows]
}
