## dynamic NSG
resource "azurerm_network_security_group" "ppdm_security_group" {
  name                = "${var.environment}-${local.ppdm_name}-security-group"
  resource_group_name      = data.azurerm_resource_group.ppdm_resource_group.name
  location                 = data.azurerm_resource_group.ppdm_resource_group.location
  dynamic "security_rule" {
    for_each = var.ppdm_tcp_inbound_rules_Vnet
    content {
      name                       = "TCP_inbound_rule_Vnet_${security_rule.key}"
      priority                   = security_rule.key * 10 + 1000
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.value
      source_address_prefix      = "VirtualNetwork"
      destination_address_prefix = "*"
    }
  }

  security_rule {
    name                       = "TCP_outbound_rule_1"
    priority                   = 1010
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = 443
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
}


resource "azurerm_network_interface_security_group_association" "ppdm_security_group" {
  network_interface_id      = azurerm_network_interface.ppdm_nic.id
  network_security_group_id = azurerm_network_security_group.ppdm_security_group.id
}
