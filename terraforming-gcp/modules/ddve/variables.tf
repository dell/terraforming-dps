variable "instance_zone" {}
variable "instance_network_name" {}
variable "instance_subnetwork_name" {}
variable "gcp_project" {}
variable "ddve_object_region" {}
variable "ddve_version" {}
variable "ddve_type" {}
variable "ddve_role_id" {}
variable "ddve_instance" {}
variable "ddve_name" {
  type    = string
  default = "ddve_terraform"
}
variable "labels" {}
variable "environment" {}
