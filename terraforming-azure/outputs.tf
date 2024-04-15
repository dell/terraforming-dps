

/* general output starts here */

output "RESOURCE_GROUP" {
  sensitive = false
  value     = var.create_common_rg ? var.common_resource_group_name : var.create_networks ? module.networks[0].resource_group_name : var.resource_group_name
}


output "AZURE_SUBSCRIPTION_ID" {
  sensitive = false
  value     = var.subscription_id
}

output "DEPLOYMENT_DOMAIN" {
  sensitive = false
  value     = var.create_networks ? module.networks[0].dns_zone_name : null
}

