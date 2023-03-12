module "vpc" {
  source  = "terraform-google-modules/network/google//modules/vpc"
  version = "~> 2.6.0"

  project_id      = var.project_id
  network_name    = var.network_name
  routing_mode    = var.routing_mode
  shared_vpc_host = var.vpc_type
}