module "my-service" {
  source                        = "../../modules/terraform-my-service"
  project                       = "${data.terraform_remote_state.gke.kubernetes_project}"
  service_name                  = "first-service"
  //  network information
  region                        = "${data.terraform_remote_state.gke.kubernetes_region}"
  subnetwork                    = "projects/${data.terraform_remote_state.gke.kubernetes_project}/regions/${data.terraform_remote_state.gke.kubernetes_region}/subnetworks/${data.terraform_remote_state.gke.kubernetes_subnetwork_name}"
  dns_managed_zone_name         = "my-private-dns-zone"
  dns_managed_zone_dns_name     = "local.domain.com."
  //  helm services data
  helm_chart                        = "../../helm/first-service"
  image_tag                         = "v1.0.1"
  //  database instance variables
  cloudsql_instance_name            = "${data.terraform_remote_state.sql-db.instance_name}"
  cloudsql_instance_address         = "${data.terraform_remote_state.sql-db.instance_address}"
  // Provider configuration
  kubernetes_cluster_endpoint       = "${data.terraform_remote_state.gke.kubernetes_endpoint}"
  cluster_ca_certificate            = "${data.terraform_remote_state.gke.cluster_ca_certificate}"
  kubernetes_service_account_tiller = "${data.terraform_remote_state.gke.kubernetes_service_account_tiller_name}"
}
