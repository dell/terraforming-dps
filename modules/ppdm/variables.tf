# ==================== Variables

variable "ENV_NAME" {
  default = ""
}
variable "PPDM_INITIAL_PASSWORD" {
  default= "Change_Me12345_"
}

variable "location" {
  default = ""
}

variable "PPDM_META_DISKS" {
    default =  ["488","10","10","5","5","5"]
}


variable "resource_group_name" {
  default = ""
}


variable "ppdm_tcp_inbound_rules_Vnet" {
    default =  ["22","2049","2051","3009"]
}
variable "ppdm_tcp_inbound_rules_Inet" {
    default =  ["443","8443"]
}
variable "public_ip" {
  type    = string
  default = "false"
}
variable "PPDM_IMAGE" {
  type = map
}
variable "ppdm_private_ip" {
  default = ""
}

variable "ppdm_image_uri" {
  default = ""
}

variable "PPDM_VM_SIZE" {
  default = ""
}


variable "subnet_id" {
  default = ""
}

variable "dns_zone_name" {
  default = ""
}

variable "ppdm_disk_type" {
  default = "Standard_LRS"
}



locals {
  # ppdm_vm          = "${var.ppdm_image_uri == "" ? 0 : 1}"
    ppdm_vm          = "1"

}

variable "autodelete" {
  default = "true"
}
variable "deployment" {
  default = "test"
}
variable "dns_subdomain" {
  default = ""
}

variable "dns_suffix" {
  default = ""
}

variable "dps_virtual_network_address_space" {
  type    = list
  default = []
}

variable "dps_infrastructure_subnet" {
  default = ""
}

variable "PPDM_HOSTNAME" {
  default = "ppdm{ENV_NAME}"
}
