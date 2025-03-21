variable "ddmc_count" {
  default     = 0
  type        = number
  description = "Do you want to create a DDMC"
}

variable "DDMC_HOSTNAME" {
  default     = "ddmc_terraform"
  description = "Hotname of the DDMC Machine"
}


variable "ddmc_version" {
  type        = string
  default     = "8.3.0.10"
  description = "DDMC Version, can be: '8.3.0.10', '7.13.1.20', '7.12.0.0', '7.10.1.50', '7.7.5.50'"
  validation {
    condition = anytrue([
      var.ddmc_version == "8.3.0.10",
      var.ddmc_version == "7.13.1.20",
      var.ddmc_version == "7.12.0.0",
      var.ddmc_version == "7.10.1.50",
      var.ddmc_version == "7.7.5.50",
    ])
    error_message = "Must be a valid DDMC Version, can be: '8.3.0.10', '7.13.1.20', '7.12.0.0', '7.10.1.50', '7.7.5.50' ."
  }
}



variable "ddmc_type" {
  type        = string
  default     = "12.5 Gigabit Ethernet DDMC"
  description = "DDMC Type, can be: '12.5 Gigabit Ethernet DDMC', '10 Gigabit Ethernet DDMC'"
  validation {
    condition = anytrue([
      var.ddmc_type == "12.5 Gigabit Ethernet DDMC",
      var.ddmc_type == "10 Gigabit Ethernet DDMC",
    ])
    error_message = "Must be a valid DDMC Type, can be: '12.5 Gigabit Ethernet DDMC', '10 Gigabit Ethernet DDMC'."
  }
}
