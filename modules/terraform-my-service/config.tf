/******************************************
  Data configuration
 *****************************************/
data "google_client_config" "default" {}

/******************************************
  Provider configuration
 *****************************************/
provider "google" {}

provider "kubernetes" {
  host     = "${var.kubernetes_cluster_endpoint}"

  token = "${data.google_client_config.default.access_token}"
  cluster_ca_certificate = "${base64decode(var.cluster_ca_certificate)}"

  load_config_file = false
}

provider "helm" {

  service_account = "${var.kubernetes_service_account_tiller}"
  install_tiller  = true

  kubernetes {
    host                    = "${var.kubernetes_cluster_endpoint}"
    token                   = "${data.google_client_config.default.access_token}"
    cluster_ca_certificate  = "${base64decode(var.cluster_ca_certificate)}"
  }

}