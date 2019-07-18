/******************************************
  dynamic value for creation of resources
 *****************************************/
resource "random_string" "name_suffix" {
  length   = 2
  upper    = false
  special  = false
}

module "sql-db" {
  source           = "../../../modules/terraform-google-sql-db"
  project          = "${var.project}"
  region           = "${var.region}"
  name             = "${terraform.workspace}-my-postgres-${random_string.name_suffix.result}"
  ip_configuration = {
    ipv4_enabled = "false"
	  private_network = "${var.network}"
  }
}
