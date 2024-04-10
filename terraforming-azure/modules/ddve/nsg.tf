resource "azurerm_network_security_group" "ddve_security_group" {
  name                = "${var.environment}-${local.ddve_name}-security-group"
  location            = data.azurerm_resource_group.ddve_resource_group.location
  resource_group_name = data.azurerm_resource_group.ddve_resource_group.name
  dynamic "security_rule" {
    for_each = var.ddve_tcp_inbound_rules_Vnet
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
  dynamic "security_rule" {
    for_each = var.ddve_tcp_inbound_rules_Inet
    content {
      name                       = "TCP_inbound_rule_Inet_${security_rule.key}"
      priority                   = security_rule.key * 10 + 1100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.value
      source_address_prefix      = "Internet"
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


resource "azurerm_network_interface_security_group_association" "ddve_security_group_nic1" {
  network_interface_id      = azurerm_network_interface.ddve_nic1.id
  network_security_group_id = azurerm_network_security_group.ddve_security_group.id
}
resource "azurerm_network_interface_security_group_association" "ddve_security_group_nic2" {
  network_interface_id      = azurerm_network_interface.ddve_nic2.id
  network_security_group_id = azurerm_network_security_group.ddve_security_group.id
}