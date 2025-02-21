variable "ppdm_count" {
  type        = number
  default     = 0
  description = "will deploy PPDM when number greater 0. Number indicates number of PPDM Instances"
}
variable "ppdm_name" {
  default     = "ppdm"
  description = "Instances wiull be named envname+ppdmname+instanceid, e.g tfdemo-ppdm1 tfdemo-ppdm2"
}

variable "ppdm_version" {
  type        = string
  default     = "19.18.0"
  description = "PPDM Version, can be: '19.16.0','19.17.0', '19.18.0'"
  validation {
    condition = anytrue([
      var.ppdm_version == "19.18.0",
      var.ppdm_version == "19.17.0",
      var.ppdm_version == "19.16.0",
    ])
    error_message = "Must be a valid PPDM Version, can be: '19.16.0','19.17.0', '19.18.0'."
  }
}
variable "ppdm_resource_group_name" {
  description = "Bring your own resourcegroup. the Code will read the Data from the resourcegroup name specified here"
  type    = string
  default = null
}
variable "ppdm_initial_password" {
  default     = "Change_Me12345_"
  description = "for use only if ansible playbooks shall hide password"
}

variable "ppdm_public_ip" {
  type        = bool
  default     = false
  description = "must we assign a public ip to ppdm"

}
