output "network_name" {
  value = module.vpc.network_name
}

output "subnet_name" {
  value = module.subnet.subnets
}

output "cloud_router" {
  value = module.cloud_router.router.name
}

output "nat_ip" {
  value = module.cloud-nat
}