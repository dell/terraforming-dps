
variable "ddve_initial_password" {
  default     = "Change_Me12345_"
  description = "the initial Password for Datadomain. It will be exposed to output as DDVE_PASSWORD for further Configuration. \nAs DD will be confiured with SSH, the Password must be changed from changeme"
}

variable "ddve_tcp_inbound_rules_Inet" {
  type        = list(string)
  default     = ["22", "443"]
  description = "inbound Traffic rule for Security Group from Internet"
}

variable "ddve_count" {
  type        = number
  default     = 0
  description = "will deploy DDVE when number greater 0. Number indicates number of DDVE Instances"
}

variable "ddve_meta_disks" {
  type    = list(string)
  default = ["1023", "1023"]
}
variable "ddve_resource_group_name" {
  description = "Bring your own resourcegroup. the Code will read the Data from the resourcegroup name specified here"
  type        = string
  default     = null
}

variable "ddve_networks_resource_group_name" {
  description = "Bring your own Network resourcegroup. the Code will read the Data from the resourcegroup name specified here"
  type        = string
  default     = null
}

variable "ddve_public_ip" {
  type        = string
  default     = "false"
  description = "Enable Public IP on Datadomain Network Interface"
}

variable "ddvelist" {
  type = map(object({
    ddve_name       = string
    ddve_meta_disks = list(string)
    ddve_type       = string
    ddve_version    = string
  }))
  description = "map describing each individual DDVE configuration"
  default = {
    firstdd = {
      ddve_name       = "ddve1"
      ddve_meta_disks = [1000, 1000]
      ddve_type       = "16 TB DDVE"
      ddve_version    = "8.0.010.MSDN"
    }
  }
  validation {
    condition = alltrue([
      for ddve in values(var.ddvelist) :
      length(ddve.ddve_name) >= 1 && length(ddve.ddve_name) <= 15
    ])
    error_message = "The Name length oh the ddve  must not exceed 15 chars"
  }
  validation {
    condition = alltrue([
      for version in values(var.ddvelist) : contains(["7.7.525", "7.7.530", "7.10.115", "7.10.120", "7.13.020", "8.0.010", "7.10.1015.MSDN", "7.10.120.MSDN", "7.7.5020.MSDN", "7.13.0020.MSDN", "8.0.010.MSDN"], version.ddve_version)
    ])
    error_message = "Must be a valid DDVE Version, can be:  '7.7.525', '7.7.530', '7.10.115', '7.10.120', '7.13.020', '8.0.010', '7.10.1015.MSDN', '7.10.120.MSDN', '7.7.5020.MSDN', '7.13.0020.MSDN', '8.0.010.MSDN' ."
  }
}




