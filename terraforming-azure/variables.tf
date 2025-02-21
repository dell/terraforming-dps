/*
Subscription Variables, should be set from env or vault
*/
variable "subscription_id" {
default = null
}
variable "tenant_id" {
default = null
}
variable "client_id" {
default = null
}
variable "client_secret" {
default = null
}
variable "location" {
default = null
}

variable "azure_environment" {
  description = "The Azure cloud environment to use. Available values at https://www.terraform.io/docs/providers/azurerm/#environment"
  default     = "public"
}

variable "environment" {}
variable "resource_group_name" {
  default = null
  description = "Default name of provided RG"
}

# ubuntu block starts here
variable "create_linux" {
  type    = bool
  default = false
  description = "a demo linux client"
}
variable "LINUX_HOSTNAME" {
  default = "client1"
}
variable "LINUX_ADMIN_USERNAME" {
  default = "ubuntu"
}

variable "LINUX_DATA_DISKS" {
  type    = list(string)
  default = []
}
variable "storage_account_cs" {
  type = string
  default = null
  description = "Storage account when using custom script extension with linux"
}
variable "storage_account_key_cs" {  
  type = string
  default = null
    description = "Storage account key when using custom script extension with linux"

}

variable "file_uris_cs" {
  type = string
  description = "File uri for custom script extension with linux"
  default = null
}

variable "LINUX_PRIVATE_IP" {
  type        = string
  description = "IP for linux instance"
  default     = "10.10.8.12"
}

variable "LINUX_IMAGE" {
  type = map(any)
  default = {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
variable "LINUX_VM_SIZE" {
  type    = string
  default = "Standard_DS1_v2"
}


