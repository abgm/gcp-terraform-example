provider "google" {}

resource "google_service_account" "default" {
  project      = "${var.project}"
  account_id   = "${var.account_id}"
  display_name = "${var.display_name}"
}

resource "google_service_account_key" "default" {
  service_account_id = "${google_service_account.default.name}"
}

resource "google_project_iam_member" "project" {
  project = "${var.project}"
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${google_service_account.default.email}"
}