locals {
  ddve_size = {
    "16 TB DDVE" = {
      instance_type  = "Standard_D4ds_v4"
      ddve_disk_type = "Standard_LRS"
    }
    "32 TB DDVE" = {
      instance_type  = "Standard_D8ds_v4"
      ddve_disk_type = "Standard_LRS"
    }
    "96 TB DDVE" = {
      instance_type  = "Standard_D16ds_v4"
      ddve_disk_type = "Standard_LRS"
    }
    "256 TB DDVE" = {
      instance_type  = "Standard_D32ds_v4"
      ddve_disk_type = "Standard_LRS"
    }
    "16 TB DDVE PERF" = {
      instance_type  = "Standard_D4ds_v4"
      ddve_disk_type = "Premium_LRS"
    }
    "32 TB DDVE PERF" = {
      instance_type  = "Standard_D8ds_v4"
      ddve_disk_type = "Premium_LRS"
    }
    "96 TB DDVE PERF" = {
      instance_type  = "Standard_D16ds_v4"
      ddve_disk_type = "Premium_LRS"
    }
    "256 TB DDVE PERF" = {
      instance_type  = "Standard_D32ds_v4"
      ddve_disk_type = "Premium_LRS"
    }
  }
  ddve_image = {
    "7.7.007" = {
      publisher = "dellemc"
      offer     = "dell-emc-datadomain-virtual-edition-v4"
      sku       = "ddve-7707"
      version   = "7.7.007"
    }
    "7.6.007" = {
      publisher = "dellemc"
      offer     = "dell-emc-datadomain-virtual-edition-v4"
      sku       = "ddve-7607"
      version   = "7.6.007"
    }
    "7.6.005" = {
      publisher = "dellemc"
      offer     = "dell-emc-datadomain-virtual-edition-v4"
      sku       = "ddve-7605"
      version   = "7.6.005"
    }
    "7.5.010" = {
      publisher = "dellemc"
      offer     = "dell-emc-datadomain-virtual-edition-v4"
      sku       = "ddve-60-ver-75010"
      version   = "7.5.010"
    }
  }
  ddve_name          = "ddve${var.ddve_instance}"
  resourcegroup_name = "${var.environment}-${local.ddve_name}"
}

resource "azurerm_resource_group" "resource_group" {
  name     = local.resourcegroup_name
  location = var.location
}


resource "random_string" "ddve_diag_storage_account_name" {
  length  = 20
  special = false
  upper   = false
}

resource "tls_private_key" "ddve" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}
resource "random_string" "fqdn_name" {
  length  = 8
  special = false
  upper   = false
}
resource "azurerm_storage_account" "ddve_diag_storage_account" {
  name                     = random_string.ddve_diag_storage_account_name.result
  resource_group_name      = azurerm_resource_group.resource_group.name
  location                 = azurerm_resource_group.resource_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    environment = var.deployment
    autodelete  = var.autodelete
  }
}

resource "azurerm_marketplace_agreement" "ddve" {
  publisher = local.ddve_image[var.ddve_version]["publisher"]
  offer     = local.ddve_image[var.ddve_version]["offer"]
  plan      = local.ddve_image[var.ddve_version]["sku"]
}
# DNS

resource "azurerm_private_dns_a_record" "ddve_dns" {
  name                = local.ddve_name
  zone_name           = var.dns_zone_name
  resource_group_name = var.resource_group_name
  ttl                 = "60"
  records             = [azurerm_network_interface.ddve_nic.ip_configuration[0].private_ip_address]
}

## dynamic NSG
resource "azurerm_network_security_group" "ddve_security_group" {
  name                = "${var.environment}-${local.ddve_name}-security-group"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
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


resource "azurerm_network_interface_security_group_association" "ddve_security_group" {
  network_interface_id      = azurerm_network_interface.ddve_nic.id
  network_security_group_id = azurerm_network_security_group.ddve_security_group.id
}

# VMs
## network interface
resource "azurerm_network_interface" "ddve_nic" {
  name                = "${var.environment}-${local.ddve_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = "${var.environment}-${local.ddve_name}-ip-config"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip == "true" ? azurerm_public_ip.publicip.0.id : null
  }
}
resource "azurerm_public_ip" "publicip" {
  count               = var.public_ip == "true" ? 1 : 0
  name                = "${var.environment}-${local.ddve_name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  domain_name_label   = "ppdd-${random_string.fqdn_name.result}"
  allocation_method   = "Dynamic"
}
resource "azurerm_virtual_machine" "ddve" {
  name                             = "${var.environment}-${local.ddve_name}"
  location                         = azurerm_resource_group.resource_group.location
  resource_group_name              = azurerm_resource_group.resource_group.name
  depends_on                       = [azurerm_network_interface.ddve_nic]
  network_interface_ids            = [azurerm_network_interface.ddve_nic.id]
  vm_size                          = local.ddve_size[var.ddve_type].instance_type
  delete_os_disk_on_termination    = "true"
  delete_data_disks_on_termination = "true"
  storage_os_disk {
    name              = "DDVEOsDisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = local.ddve_size[var.ddve_type].ddve_disk_type
  }
  storage_data_disk {
    name              = "nvr-disk"
    disk_size_gb      = "10"
    create_option     = "FromImage"
    managed_disk_type = local.ddve_size[var.ddve_type].ddve_disk_type
    lun               = "0"
  }

  dynamic "storage_data_disk" {
    for_each = var.ddve_meta_disks
    content {
      name              = "Metadata-${storage_data_disk.key + 1}"
      lun               = storage_data_disk.key + 1
      disk_size_gb      = storage_data_disk.value
      create_option     = "empty"
      managed_disk_type = local.ddve_size[var.ddve_type].ddve_disk_type
    }
  }

  plan {
    publisher = local.ddve_image[var.ddve_version]["publisher"]
    product   = local.ddve_image[var.ddve_version]["offer"]
    name      = local.ddve_image[var.ddve_version]["sku"]

  }

  storage_image_reference {
    publisher = local.ddve_image[var.ddve_version]["publisher"]
    offer     = local.ddve_image[var.ddve_version]["offer"]
    sku       = local.ddve_image[var.ddve_version]["sku"]
    version   = local.ddve_image[var.ddve_version]["version"]
  }
  os_profile {
    computer_name  = local.ddve_name
    admin_username = "sysadmin"
    admin_password = var.ddve_password
  }
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data = tls_private_key.ddve.public_key_openssh
      path     = "/home/sysadmin/.ssh/authorized_keys"
    }

  }

  boot_diagnostics {
    enabled     = "true"
    storage_uri = azurerm_storage_account.ddve_diag_storage_account.primary_blob_endpoint
  }

  tags = {
    environment = var.deployment
  }
}
