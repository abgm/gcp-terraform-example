terraform {
  backend "gcs" {
    bucket = "my-infrastructure"
    prefix = "services/second-service"
  }
}

data "terraform_remote_state" "gke" {
  backend   = "gcs"
  workspace = "${terraform.workspace}"

  config {
    bucket = "my-infrastructure"
    prefix = "infrastructure/environment/gke"
  }
}

data "terraform_remote_state" "sql-db" {
  backend   = "gcs"
  workspace = "${terraform.workspace}"

  config {
    bucket = "my-infrastructure"
    prefix = "infrastructure/environment/sql-db"
  }
}