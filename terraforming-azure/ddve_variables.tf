
variable "ddve_initial_password" {
  default = "Change_Me12345_"
  description = "the initial Password for Datadomain. It will be exposed to output as DDVE_PASSWORD for further Configuration. \nAs DD will be confiured with SSH, the Password must be changed from changeme"
}

variable "ddve_tcp_inbound_rules_Inet" {
  type    = list(string)
  default = ["22", "443"]
  description = "inbound Traffic rule for Security Group from Internet"
}

variable "ddve_count" {
  type    = number
  default = 0
  description = "will deploy DDVE when number greater 0. Number indicates number of DDVE Instances"
}

variable "ddve_meta_disks" {
  type    = list(string)
  default = ["1023", "250", "250"]
}



variable "ddve_public_ip" {
  type    = string
  default = "false"
  description = "Enable Public IP on Datadomain Network Interface"
}

variable "ddve_version" {
  type        = string
  default     = "7.8.000"
  description = "DDVE Version, can be: '7.7.007', '7.6.007', '7.6.005', '7.5.010'"
  validation {
    condition = anytrue([
      var.ddve_version == "7.8.000",
      var.ddve_version == "7.7.100",
      var.ddve_version == "7.7.007",
      var.ddve_version == "7.6.007",
      var.ddve_version == "7.6.005",
      var.ddve_version == "7.5.010",
    ])
    error_message = "Must be a valid DDVE Version, can be: '7.7.007', '7.6.007', '7.6.005', '7.5.010'."
  }
}


variable "ddve_type" {
  type        = string
  default     = "16 TB DDVE"
  description = "DDVE Type, can be: '16 TB DDVE', '32 TB DDVE', '96 TB DDVE', '256 TB DDVE','16 TB DDVE PERF', '32 TB DDVE PERF', '96 TB DDVE PERF', '256 TB DDVE PERF'"
  validation {
    condition = anytrue([
      var.ddve_type == "16 TB DDVE",
      var.ddve_type == "32 TB DDVE",
      var.ddve_type == "96 TB DDVE",
      var.ddve_type == "256 TB DDVE",
      var.ddve_type == "16 TB DDVE PERF",
      var.ddve_type == "32 TB DDVE PERF",
      var.ddve_type == "96 TB DDVE PERF",
      var.ddve_type == "256 TB DDVE PERF"
    ])
    error_message = "Must be a valid DDVE Type, can be: '16 TB DDVE', '32 TB DDVE', '96 TB DDVE', '256 TB DDVE'."
  }
}

