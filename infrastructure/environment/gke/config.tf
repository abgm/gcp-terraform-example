terraform {
  backend "gcs" {
    bucket = "my-infrastructure"
    prefix = "infrastructure/environment/gke"
  }
}