variable "ddve_count" {
  default     = 0
  type        = number
  description = "Do you want to create a DDVE"
}

variable "DDVE_HOSTNAME" {
  default     = "ddve-tf"
  description = "Hotname of the DDVE Machine"
}


variable "ddve_version" {
  type        = string
  default     = "8.1.0.10"
  description = "DDVE Version, can be: 'LTS2022 7.7.5.50', 'LTS2023 7.10.1.40', 'LTS2024 7.13.1.05','8.1.0.10' " 
  validation {
    condition = anytrue([
      var.ddve_version == "LTS2022 7.7.5.50",
      var.ddve_version == "LTS2023 7.10.1.40",
      var.ddve_version == "LTS2024 7.13.1.05",
      var.ddve_version == "8.1.0.10",
    ])
    error_message = "Must be a valid DDVE Version, can be: 'LTS2022 7.7.5.50', 'LTS2023 7.10.1.40', 'LTS2024 7.13.1.05','8.1.0.10' ."
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

variable "ddve_source_tags" {
  type        = list(any)
  default     = []
  description = "Source tags applied to Instance for Firewall Rules"

}
variable "ddve_target_tags" {
  type        = list(any)
  default     = []
  description = "Target tags applied to Instance for Firewall Rules"

}
variable "ddve_sa_account_id" {
  description = "The ID of the Service Account for DDVE IAM Policy to Access Storage Bucket via OAuth, in ther form of"

  default = ""
}


variable "ddve_disk_type" {
  type        = string
  default     = "Cost Optimized"
  description = "DDVE Disk Type, can be: 'Performance Optimized', 'Cost Optimized'"
  validation {
    condition = anytrue([
      var.ddve_disk_type == "Performance Optimized",
      var.ddve_disk_type == "Cost Optimized"
    ])
    error_message = "Must be a valid DDVE Disk Type, can be: 'Performance Optimized', 'Cost Optimized'."
  }
}
