variable "project_id" {
  description = "Host project id"
  type        = string
}

variable "network_name" {
  description = "Name of the network"
  type        = string
}

variable "subnet" {
  type    = list(map(string))
  default = []

}