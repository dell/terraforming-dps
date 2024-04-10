resource "azurerm_private_dns_a_record" "ddve_dns" {
  name                = local.ddve_name
  zone_name           = var.dns_zone_name
  resource_group_name = var.resource_group_name
  ttl                 = "60"
  records             = [azurerm_network_interface.ddve_nic1.ip_configuration[0].private_ip_address]
}
