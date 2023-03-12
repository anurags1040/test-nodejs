module "vpc" {
  source  = "terraform-google-modules/network/google//modules/vpc"
  version = "~> 2.6.0"

  project_id      = var.project_id
  network_name    = var.network_name
  routing_mode    = var.routing_mode
  # shared_vpc_host = var.vpc_type
}

module "subnet" {
  source  = "terraform-google-modules/network/google//modules/subnets"
  version = "~> 4.0"

  project_id   = var.project_id
  network_name = module.vpc.network_name
  subnets      = var.subnet
  secondary_ranges = var.secondary_ranges
}

module "cloud_router" {
  source  = "terraform-google-modules/cloud-router/google"
  version = "~> 0.4"

  name    = var.cloudrouter_name
  project = var.project_id
  region  = var.region
  network = module.vpc.network_name
}

module "cloud-nat" {
  source                             = "terraform-google-modules/cloud-nat/google"
  version                            = "~> 1.2"
  project_id                         = var.project_id
  region                             = var.region
  router                             = module.cloud_router.router.name
  name                               = "cloud-nat-cloud-router"
  nat_ips                            = var.nat_addresses
  source_subnetwork_ip_ranges_to_nat = var.source_subnetwork_ip_ranges_to_nat
  subnetworks                        = var.subnetworks
  depends_on = [
    module.cloud_router
  ]
}


resource "google_compute_firewall" "rules" {
  network                 = module.vpc.network_name
  project                 = var.project_id
  for_each                = { for fw in var.fw-rules : fw.name => fw }
  name                    = each.value.name
  description             = each.value.description
  direction               = each.value.direction
  source_ranges           = each.value.direction == "INGRESS" ? each.value.ranges : null
  destination_ranges      = each.value.direction == "EGRESS" ? each.value.ranges : null
  source_tags             = each.value.source_tags
  source_service_accounts = each.value.source_service_accounts
  target_tags             = each.value.target_tags
  target_service_accounts = each.value.target_service_accounts
  priority                = each.value.priority

  dynamic "log_config" {
    for_each = lookup(each.value, "log_config") == null ? [] : [each.value.log_config]
    content {
      metadata = log_config.value.metadata
    }
  }

  dynamic "allow" {
    for_each = lookup(each.value, "allow", [])
    content {
      protocol = allow.value.protocol
      ports    = lookup(allow.value, "ports", null)
    }
  }

  dynamic "deny" {
    for_each = lookup(each.value, "deny", [])
    content {
      protocol = deny.value.protocol
      ports    = lookup(deny.value, "ports", null)
    }
  }
}