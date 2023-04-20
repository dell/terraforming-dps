terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.61.0"
      // version = "= 3.72.0"
    }
  }
}

provider "google" {
  credentials = var.gcp_credentials
  project     = var.gcp_project
  region      = var.gcp_region
  zone        = var.gcp_zone
}
provider "google-beta" {
  credentials = var.gcp_credentials
  project     = var.gcp_project
  region      = var.gcp_region
  zone        = var.gcp_zone
}
provider "kubernetes" {
  load_config_file = "false"
  host             = google_container_cluster.primary.endpoint

  client_certificate     = google_container_cluster.primary.master_auth.0.client_certificate
  client_key             = google_container_cluster.primary.master_auth.0.client_key
  cluster_ca_certificate = google_container_cluster.primary.master_auth.0.cluster_ca_certificate
}
module "networks" {
  count                         = var.create_networks ? 1 : 0 // terraform  >=0.13 only  
  source                        = "./modules/networks"
  labels                        = var.labels
  environment                   = var.ENV_NAME
  gcp_project                   = var.gcp_project
  subnet_region                 = var.gcp_region
  subnetwork_name               = var.gcp_subnetwork_name_1
  subnet_cidr_block             = var.gcp_subnet_cidr_block_1
  subnet_secondary_cidr_block_0 = var.gke_subnet_secondary_cidr_block_0
  subnet_secondary_cidr_block_1 = var.gke_subnet_secondary_cidr_block_1
  network_name                  = var.gcp_network
}


module "cloud_nat" {
  count         = var.create_cloud_nat ? 1 : 0 // terraform  >=0.13 only  
  source        = "./modules/cloud_nat"
  depends_on    = [module.networks]
  labels        = var.labels
  environment   = var.ENV_NAME
  gcp_project   = var.gcp_project
  subnet_region = var.gcp_region
  network_name  = var.gcp_network
}

module "s2svpn" {
  count             = var.create_s2svpn ? 1 : 0 // terraform  >=0.13 only  
  source            = "./modules/s2svpn"
  depends_on        = [module.networks]
  labels            = var.labels
  environment       = var.ENV_NAME
  gcp_project       = var.gcp_project
  ike_shared_secret = var.vpn_shared_secret
  network_name      = var.gcp_network
  peer_ip           = var.vpn_wan_ip
  vpn_route_dest    = var.s2s_vpn_route_dest
}

module "ppdm" {
  count                    = var.ppdm_count > 0 ? var.ppdm_count : 0
  ppdm_instance            = count.index + 1
  labels                   = var.labels
  environment              = var.ENV_NAME
  source                   = "./modules/ppdm"
  depends_on               = [module.networks]
  ppdm_name                = var.PPDM_HOSTNAME
  instance_zone            = var.gcp_zone
  instance_network_name    = var.gcp_network
  instance_subnetwork_name = var.gcp_subnetwork_name_1
  ppdm_version             = var.ppdm_version
  instance_size            = "custom-8-32768" //don´t change this walue

}

module "ddve" {
  count                    = var.ddve_count > 0 ? var.ddve_count : 0
  ddve_instance            = count.index + 1
  source                   = "./modules/ddve"
  labels                   = var.labels
  environment              = var.ENV_NAME
  depends_on               = [module.networks]
  ddve_name                = var.DDVE_HOSTNAME
  instance_zone            = var.gcp_zone
  ddve_object_region       = var.gcp_region
  instance_network_name    = var.gcp_network
  instance_subnetwork_name = var.gcp_subnetwork_name_1
  ddve_type                = var.ddve_type
  ddve_role_id             = var.ddve_role_id
  ddve_version             = var.ddve_version
  gcp_project              = var.gcp_project
}
module "ddve_project_role" {
  count        = var.create_ddve_project_role ? 1 : 0 // terraform  >=0.13 only  
  source       = "./modules/ddve_project_role"
  ddve_role_id = var.ddve_role_id
  gcp_project  = var.gcp_project
}


module "gke" {
  count                         = var.create_gke ? 1 : 0 // terraform  >=0.13 only
  source                        = "./modules/gke"
  depends_on                    = [module.networks]
  labels                        = var.labels
  environment                   = var.ENV_NAME
  gcp_project                   = var.gcp_project
  gke_num_nodes                 = var.gke_num_nodes
  network_name                  = var.gcp_network
  subnetwork_name               = var.gcp_subnetwork_name_1
  subnet_secondary_cidr_block_0 = var.gke_subnet_secondary_cidr_block_0
  subnet_secondary_cidr_block_1 = var.gke_subnet_secondary_cidr_block_1
  master_ipv4_cidr_block        = var.gke_master_ipv4_cidr_block
  region                        = var.gcp_region // selecting a zone will create a zonal cluster, a gegion a regionla cluster
  zone                          = var.gcp_zone   // selecting a zone will create a zonal cluster, a gegion a regionla cluster
  location                      = var.gke_zonal ? var.gcp_zone : var.gcp_region
}
