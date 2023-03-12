variable "project_id" {
  type = string
}
variable "region" {
  type = string
}
# variable "zone" {
#   type = string
# }
variable "vpc_network_name" {
#   type = string
}

variable "firewall_internal_allow_cidr" {
  type = list(string)
}
variable "use_cloud_nat" { 
  default=true
  }
#########  private cluster specific variables #############

variable "cluster_name" {
  type = string
 }
variable "cluster_version_prefix" { 
  type = string
}

variable "enable_private_endpoint" { 
  type = bool
  default=false 
  }

variable "subnetwork_name" {
#   type = string
}

variable "cluster_service_account" {
    type = string
}

variable "secondary_range_services_name" {
  type = string
}
variable "secondary_range_pods_name" { 
  type = string
}

variable "master_ipv4_cidr_block_28" {
  type = string
 }
variable "master_authorized_networks_cidr_list" {
  type=list(string)
  default=[]
}