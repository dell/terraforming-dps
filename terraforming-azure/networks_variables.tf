/*
Network Module Variables, if not derived from environment/tfvars
*/
variable "create_networks" {
  type    = bool
  default = false
  description = "if set to true, we will create networks in the environment"
}

variable "dns_suffix" {
  description = "the DNS suffig when we create a network with internal dns"
}

variable "enable_aks_subnet" {
  description = "If set to true, create subnet for aks"
  type        = bool
  default     = false
}

variable "enable_tkg_controlplane_subnet" {
  description = "If set to true, create subnet for tkg controlplane"
  type        = bool
  default     = false
}
variable "enable_tkg_workload_subnet" {
  description = "If set to true, create subnet for tkg workload"
  type        = bool
  default     = false
}



variable "virtual_network_address_space" {
  type    = list(any)
  default = ["10.10.0.0/16"]
#  default = ["10.10.0.0/16","fd00:db8:deca:daed::/64"]
}

variable "infrastructure_subnet" {
  type    = list(string)
  default = ["10.10.8.0/26"]
}
variable "aks_subnet" {
  type    = list(string)
  default = ["10.10.6.0/24"]
}
variable "vpn_subnet" {
  type    = list(string)
  default = ["10.10.12.0/24"]
}
variable "tkg_workload_subnet" {
  type    = list(string)
  default = ["10.10.4.0/24"]
}
variable "tkg_controlplane_subnet" {
  type    = list(string)
  default = ["10.10.2.0/24"]
}
variable "azure_bastion_subnet" {
  type    = list(string)
  default = ["10.10.0.224/27"]
}
variable "create_bastion" {
  type = bool
  default = false
}
variable "networks_infrastructure_resource_group_name" {
  description = "name ofb the network rg when using existing"  
  default = null
}

variable "networks_dns_zone_name" {
  default = null
}

variable "networks_infrastructure_subnet_id" {
  default = null
  description = "Id of the subnet when using existing"
}

variable "vnet_name" {
  default = null
}
variable "network_rg_name" {
  default     =null
  description = "The RG for Network if different is used for existing vnet"
}



