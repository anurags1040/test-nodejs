provider "google" {}

data "terraform_remote_state" "shared-xpn" {
    backend = "gcs"
    config = {
       bucket = "tt-tfstate-bucket"
       prefix = "terraform/shared-xpn/"
    }
}