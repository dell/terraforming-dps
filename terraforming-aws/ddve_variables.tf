variable "ddve_count" {
  default     = 0
  type        = number
  description = "Do you want to create a DDVE"
}

variable "DDVE_HOSTNAME" {
  default     = "ddve_terraform"
  description = "Hotname of the DDVE Machine"
}


variable "ddve_version" {
  type        = string
  default     = "8.1.0.10"
  description = "DDVE Version, can be: '8.1.0.10', '7.13.1.10','7.10.1.50', '7.7.5.50'"
  validation {
    condition = anytrue([
      var.ddve_version == "8.1.0.10",
      var.ddve_version == "7.13.1.10",
      var.ddve_version == "7.10.1.50",
      var.ddve_version == "7.7.5.50",
    ])
    error_message = "Must be a valid DDVE Version, can be: '8.1.0.10', '7.13.1.10','7.10.1.50', '7.7.5.50' ."
  }
}



variable "ddve_type" {
  type        = string
  default     = "16 TB DDVE"
  description = "DDVE Type, can be: '16 TB DDVE', '32 TB DDVE', '96 TB DDVE', '256 TB DDVE'"
  validation {
    condition = anytrue([
      var.ddve_type == "16 TB DDVE",
      var.ddve_type == "32 TB DDVE",
      var.ddve_type == "96 TB DDVE",
      var.ddve_type == "256 TB DDVE"

    ])
    error_message = "Must be a valid DDVE Type, can be: '16 TB DDVE', '32 TB DDVE', '96 TB DDVE', '256 TB DDVE'."
  }
}
