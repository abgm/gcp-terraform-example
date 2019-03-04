provider "google-beta" {}

terraform {
  backend "gcs" {
    bucket = "my-infrastructure"
    prefix = "infrastructure/global/peering-google-api"
  }
}
