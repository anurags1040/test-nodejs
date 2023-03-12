terraform {
  required_version = ">= 0.13.6" # see https://releases.hashicorp.com/terraform/
}

provider "google" {
  version = "4.44.0" # see https://github.com/terraform-providers/terraform-provider-google/releases
  project = var.project_id
  region  = "us-west1"
  zone    = "us-west1-a"
}

provider "google-beta" {
  version = "4.44.0" # see https://github.com/terraform-providers/terraform-provider-google-beta/releases
  project = var.project_id
  region  = "us-west1"
  zone    = "us-west1-a"
}

provider "random" {
  version = "3.4.2" # see https://github.com/hashicorp/terraform-provider-random/releases
}

data "google_client_config" "google_client" {}
