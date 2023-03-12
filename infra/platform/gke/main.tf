module "gcp-gke-private-autopilot-cluster" {
  source = "../../modules/gke-ap/"

  project = var.project_id
  region = var.region
#   zone = var.zone
  vpc_network_name = var.vpc_network_name

  cluster_name = var.cluster_name
  cluster_version_prefix = var.cluster_version_prefix
  enable_private_endpoint = var.enable_private_endpoint
  subnetwork_name = var.subnetwork_name
  cluster_service_account = var.cluster_service_account
  secondary_range_services_name = var.secondary_range_services_name
  secondary_range_pods_name = var.secondary_range_pods_name
  master_ipv4_cidr_block_28 = var.master_ipv4_cidr_block_28

  master_authorized_networks_cidr_list = var.master_authorized_networks_cidr_list

#   depends_on = [
#     module.gcp-networks
#   ]
  
}