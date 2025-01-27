
variable "ppdm_count" {
  default     = 0
  type        = number
  description = "Do you want to create an PPDM"
}


variable "PPDM_HOSTNAME" {
  default     = "ppdm_terraform"
  description = "Hotname of the PPDM Machine"
}


variable "ppdm_version" {
  type        = string
  default     = "19.18.0"
  description = "VERSION Version, can be: '19.18.0', '19.17.0'"
  validation {
    condition = anytrue([
      var.ppdm_version == "19.18.0",
      var.ppdm_version == "19.17.0",

    ])
    error_message = "Must be a valid PPDM Version, can be: '19.18.0', '19.17.0', ."
  }
}