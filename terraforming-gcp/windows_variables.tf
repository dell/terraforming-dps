variable "windows_count" {
  default     = 0
  type        = number
  description = "Do you want to create a windows"
}
variable "windows_HOSTNAME" {
  default     = "windows-tf"
  description = "Hotname Prefix (adds counting number) of the windows Machine"
}

variable "windows_source_tags" {
  type        = list(any)
  default     = []
  description = "Source tags applied to Instance for Firewall Rules"

}
variable "windows_target_tags" {
  type        = list(any)
  default     = []
  description = "Target tags applied to Instance for Firewall Rules"

}
variable "windows_deletion_protection" {
  type        = bool
  default     = false
  description = "Protect windows from deletion"

}

