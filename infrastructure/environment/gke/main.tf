/******************************************
  dynamic value for creation of resources
  need to be lower case because of the account_id
 *****************************************/
resource "random_string" "name_suffix" {
  length   = 2
  upper    = false
  special  = false
}

module "gke" {
  source                        = "../../../modules/terraform-google-gke"
  project                       = "${var.project}"
  region                        = "${var.region}"
  network                       = "${var.network}"
  cluster_name                  = "${terraform.workspace}-my-cluster-${random_string.name_suffix.result}"
  master_ipv4_cidr_block        = "${var.master_ipv4_cidr_block}"
}
