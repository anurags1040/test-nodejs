module "artifacts" {
  source = "../../modules/artifact-registry"

  location      = var.location
  repository_id = var.repository_id
  description   = var.description
  format        = var.format
  project_id      = "peak-apparatus-379619"
}