variable "project_id" {
  description = "Name of the network"
  type        = string
}

variable "network_name" {
  description = "Name of the network"
  type        = string
}

# variable "vpc_type" {
#   description = "Enable or disable shared vpc host project"
#   type        = bool
#   default     = false
# }

variable "routing_mode" {
  description = "Enable or disable shared vpc host project"
  type        = string
  default     = "GLOBAL"
}


variable "subnet" {
  type    = list(map(string))
  default = []
}

variable "secondary_ranges" {
  type        = map(list(object({ range_name = string, ip_cidr_range = string })))
  description = "Secondary ranges that will be used in some of the subnets"
  default     = {}
}

variable "cloudrouter_name" {
  description = "Name of the cloud router"
}

variable "region" {
  description = "Region where router is deployed"
}

variable "nat_addresses" {
  default     = []
  type        = list(string)
  description = "The self_link of GCP Addresses to associate with the NAT"
}

variable "source_subnetwork_ip_ranges_to_nat" {
  description = "(Optional) Defaults to ALL_SUBNETWORKS_ALL_IP_RANGES. How NAT should be configured per Subnetwork. Valid values include: ALL_SUBNETWORKS_ALL_IP_RANGES, ALL_SUBNETWORKS_ALL_PRIMARY_IP_RANGES, LIST_OF_SUBNETWORKS. Changing this forces a new NAT to be created."
  default     = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

variable "subnetworks" {
  type = list(object({
    name                     = string,
    source_ip_ranges_to_nat  = list(string)
    secondary_ip_range_names = list(string)
  }))
  default = []
}


variable "fw-rules" {
  description = "List of custom rule definitions (refer to variables file for syntax)."
  default     = []
  type = list(object({
    name                    = string
    description             = string
    direction               = string
    priority                = number
    ranges                  = list(string)
    source_tags             = list(string)
    source_service_accounts = list(string)
    target_tags             = list(string)
    target_service_accounts = list(string)
    allow = list(object({
      protocol = string
      ports    = list(string)
    }))
    deny = list(object({
      protocol = string
      ports    = list(string)
    }))
    log_config = object({
      metadata = string
    })
  }))
}