/******************************************
  Data configuration
 *****************************************/
data "google_client_config" "default" {}

/******************************************
  Provider configuration
 *****************************************/
provider "google" {}
provider "google-beta" {}

provider "kubernetes" {
  host     = "${google_container_cluster.default.endpoint}"

  token = "${data.google_client_config.default.access_token}"
  cluster_ca_certificate = "${base64decode(google_container_cluster.default.master_auth.0.cluster_ca_certificate)}"

  load_config_file = false
}