# ---gke-autopilot/variables.tf---

variable "project" {
  type = string
}
variable "region" {
    type = string
}
# variable "zone" {  
#   type = string
# }

variable "vpc_network_name" {
    # type = string
    # default = "mynetwork"
}



##########  private Autopilot cluster specific variables #############

variable "cluster_name" { 
    type = string
}

# whether kubectl endpoint available publicly
variable "enable_private_endpoint" { 
  type = bool
  default = false
   }

variable "subnetwork_name" {
    # type = string
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

# terraform says repair+upgrade must be true when REGULAR
variable "cluster_version_prefix" { 
  type = string
  default="1.23.8"
 }
variable "cluster_release_channel" { 
  type = string
  default= "REGULAR"
   }

# authorized networks empty by default
variable "master_authorized_networks_cidr_list" { 
  type = list
  default=[] 
} 

variable "cluster_service_account" {
  type = string
}

variable "node_ap_oauth_scopes" {
  type = list(string)
  default = [
    "https://www.googleapis.com/auth/cloud-platform",
  ]
}
variable "node_ap_network_tags_list" {
  type = list(string)
  default = ["gke-node"]
}
variable "node_ap_labels_map" {
  type = map
  default = {
    foo = "bar"
  }
}