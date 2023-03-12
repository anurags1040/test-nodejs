resource "google_compute_global_address" "private_ip_address" {
  provider = google-beta

  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.network_name
}

resource "google_service_networking_connection" "private_vpc_connection" {
  provider = google-beta

  network                 = var.network_name
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}




module "sql-db" {
  source = "GoogleCloudPlatform/sql-db/google//modules/mysql"
  project_id        = "peak-apparatus-379619"
  database_version  = var.database_version
  name              = var.resource_name
  db_name           = var.db_name
  # region            = var.region
  zone              = "us-central1-a"
  availability_type = "ZONAL"
  root_password     = var.root_password
  ip_configuration  = var.ip_configuration

}