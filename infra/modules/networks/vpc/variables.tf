variable "project_id" {
  description = "Host project id"
  type        = string
}

variable "network_name" {
  description = "Name of the network"
  type        = string
}

variable "vpc_type" {
  description = "Enable or disable shared vpc host project"
  type        = bool
  default     = false
}

variable "routing_mode" {
  description = "Enable or disable shared vpc host project"
  type        = string
  default     = "GLOBAL"
}