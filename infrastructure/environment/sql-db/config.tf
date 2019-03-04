terraform {
  backend "gcs" {
    bucket = "my-infrastructure"
    prefix = "infrastructure/environment/sql-db"
  }
}