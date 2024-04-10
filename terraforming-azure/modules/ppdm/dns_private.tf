resource "azurerm_private_dns_a_record" "ppdm_dns" {
  name                = local.ppdm_name
  zone_name           = var.dns_zone_name
  resource_group_name      = data.azurerm_resource_group.ppdm_networks_resource_group.name
  ttl                 = "60"
  records             = [azurerm_network_interface.ppdm_nic.ip_configuration[0].private_ip_address]
}
