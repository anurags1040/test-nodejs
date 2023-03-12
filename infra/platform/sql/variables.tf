variable "network_name" {
  type = string
}

variable "database_version" {
  type    = string
  default = "MYSQL_8_0"
}

variable "resource_name" {
  type = string
  description = "The name of the Cloud SQL resources"
}

variable "db_name" {
  type = string
  description = "The name of the default database to create	"
}

# variable "region" {
#   type = string
# }

variable "root_password" {
  type      = string
  sensitive = true
}

variable "ip_configuration" {
  type = object({
    authorized_networks = list(map(string))
    ipv4_enabled        = bool
    private_network     = string
    require_ssl         = bool
    allocated_ip_range  = string
  })
}