resource "azurerm_private_dns_a_record" "ddve_dns" {
  name                = var.ddve_instance
  zone_name           = var.dns_zone_name
  resource_group_name = data.azurerm_resource_group.ddve_networks_resource_group.name
  ttl                 = "60"
  records             = [azurerm_network_interface.ddve_nic1.ip_configuration[0].private_ip_address]
}
