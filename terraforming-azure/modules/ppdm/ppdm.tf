locals {
  ppdm_image = {
    "19.16.0" = {
      publisher = "dellemc"
      offer     = "ppdm_0_0_1"
      sku       = "powerprotect-data-manager-19-16-0-11"
      version   = "19.16.0"
    }      
    "19.15.0" = {
      publisher = "dellemc"
      offer     = "ppdm_0_0_1"
      sku       = "powerprotect-data-manager-19-15-0-17"
      version   = "19.15.0"
    }    
    "19.14.0" = {
      publisher = "dellemc"
      offer     = "ppdm_0_0_1"
      sku       = "powerprotect-data-manager-19-14-0-20"
      version   = "19.14.0"
    }    
  }
  ppdm_vm_size       = "Standard_D8s_v3"
  ppdm_name          = "${var.ppdm_name}${var.ppdm_instance}"
  resourcegroup_name = "${var.environment}-${local.ppdm_name}"
  ppdm_meta_disks    = ["500", "10", "10", "5", "5", "5"]
}


data "azurerm_resource_group" "ppdm_networks_resource_group" {
  name = var.ppdm_networks_resource_group_name
}
data "azurerm_resource_group" "ppdm_resource_group" {
  name = var.ppdm_resource_group_name
}


data "http" "myip" {
  url = "https://ipv4.icanhazip.com"
}


resource "random_string" "ppdm_diag_storage_account_name" {
  length  = 20
  special = false
  upper   = false
}
resource "random_string" "fqdn_name" {
  length  = 8
  special = false
  upper   = false
}
resource "tls_private_key" "ppdm" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "azurerm_storage_account" "ppdm_diag_storage_account" {
  name                     = random_string.ppdm_diag_storage_account_name.result
  resource_group_name      = data.azurerm_resource_group.ppdm_resource_group.name
  location                 = data.azurerm_resource_group.ppdm_resource_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version = "TLS1_2"
  enable_https_traffic_only = true
  network_rules {
    default_action             = "Deny"
    ip_rules = [chomp(data.http.myip.response_body)]
    virtual_network_subnet_ids = [var.subnet_id]
  }
  tags = {
    environment = var.deployment
    autodelete  = var.autodelete
  }
}

resource "azurerm_marketplace_agreement" "ppdm" {
  count = var.ppdm_instance == 1 ? 1 : 0
  publisher = local.ppdm_image[var.ppdm_version]["publisher"]
  offer     = local.ppdm_image[var.ppdm_version]["offer"]
  plan      = local.ppdm_image[var.ppdm_version]["sku"]
}




# VMs
## network interface
resource "azurerm_network_interface" "ppdm_nic" {
  name                = "${var.environment}-${local.ppdm_name}-nic"
  resource_group_name      = data.azurerm_resource_group.ppdm_networks_resource_group.name
  location                 = data.azurerm_resource_group.ppdm_networks_resource_group.location
  ip_configuration {
    name                          = "${var.environment}-${local.ppdm_name}-ip-config"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip == "true" ? azurerm_public_ip.publicip.0.id : null
  }
}
resource "azurerm_public_ip" "publicip" {
  count               = var.public_ip == "true" ? 1 : 0
  name                = "${var.environment}-${local.ppdm_name}-pip"
  resource_group_name      = data.azurerm_resource_group.ppdm_networks_resource_group.name
  location                 = data.azurerm_resource_group.ppdm_networks_resource_group.location
  allocation_method   = "Dynamic"
  domain_name_label   = "ppdm-${random_string.fqdn_name.result}"
}


resource "azurerm_virtual_machine" "ppdm" {
  name                             = "${var.environment}-${local.ppdm_name}"
  resource_group_name              = data.azurerm_resource_group.ppdm_resource_group.name
  location                         = data.azurerm_resource_group.ppdm_resource_group.location
  depends_on                       = [azurerm_network_interface.ppdm_nic]
  network_interface_ids            = [azurerm_network_interface.ppdm_nic.id]
  vm_size                          = local.ppdm_vm_size
  delete_os_disk_on_termination    = "true"
  delete_data_disks_on_termination = "true"
  storage_os_disk {
    name              = "${local.ppdm_name}-ppdmOsDisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = var.ppdm_disk_type
  }

  dynamic "storage_data_disk" {
    for_each = local.ppdm_meta_disks
    content {
      name              = "${local.ppdm_name}-DataDisk-${storage_data_disk.key + 1}"
      lun               = storage_data_disk.key
      disk_size_gb      = storage_data_disk.value
      create_option     = "FromImage"
      managed_disk_type = var.ppdm_disk_type
    }
  }

  plan {
    name      = local.ppdm_image[var.ppdm_version]["sku"]
    publisher = local.ppdm_image[var.ppdm_version]["publisher"]
    product   = local.ppdm_image[var.ppdm_version]["offer"]
  }

  storage_image_reference {
    #    id = local.ppdm_image[var.ppdm_version]["id"]
    publisher = local.ppdm_image[var.ppdm_version]["publisher"]
    offer     = local.ppdm_image[var.ppdm_version]["offer"]
    sku       = local.ppdm_image[var.ppdm_version]["sku"]
    version   = local.ppdm_image[var.ppdm_version]["version"]
  }
  os_profile {
    computer_name  = local.ppdm_name
    admin_username = "ppdmadmin"
  }
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data = tls_private_key.ppdm.public_key_openssh
      path     = "/home/ppdmadmin/.ssh/authorized_keys"
    }
  }


  boot_diagnostics {
    enabled     = "true"
    storage_uri = azurerm_storage_account.ppdm_diag_storage_account.primary_blob_endpoint
  }

  tags = {
    environment = var.deployment
  }
}
