terraform {
  required_version = ">= 0.13.0"
  backend "gcs" {
    bucket = "tt-tfstate-bucket"
    prefix = "terraform/artifacts/"
  }
}