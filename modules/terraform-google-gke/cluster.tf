data "google_compute_zones" "available" {
  project = "${var.project}"
  region = "${var.region}"
  status = "UP"
}

/******************************************
  Cluster configuration
 *****************************************/
resource "google_container_cluster" "default" {
  project = "${var.project}"

  name = "${var.cluster_name}"

  zone = "${data.google_compute_zones.available.names[0]}"

  additional_zones = ["${data.google_compute_zones.available.names[1]}"]

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count = 1

  min_master_version = "1.11.6-gke.6"

  master_auth {
    username = ""
    password = ""
  }

  ip_allocation_policy {
    create_subnetwork = "true"
    subnetwork_name="${var.cluster_name}"
  }

  private_cluster_config {
    enable_private_endpoint = "false"
    enable_private_nodes = "true"
    master_ipv4_cidr_block = "${var.master_ipv4_cidr_block}"
  }

  network = "${var.network}"

  # https://github.com/terraform-providers/terraform-provider-google/issues/2231
  master_authorized_networks_config {
    cidr_blocks = [
      {
        display_name = "all for now"
        cidr_block = "0.0.0.0/0"
      },
    ]
  }

  maintenance_policy {
    "daily_maintenance_window" {
      start_time = "03:00"
    }
  }
  logging_service = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"

  resource_labels {
    created-by = "terraform"
    source-cloud = "my-infrastruture"
  }

}

resource "google_container_node_pool" "default" {

  project = "${var.project}"

  name = "custom-pool-1"

  zone = "${data.google_compute_zones.available.names[0]}"

  cluster = "${google_container_cluster.default.name}"

  initial_node_count = "${var.initial_node_count}"

  autoscaling {
    max_node_count = "${var.max_node_count}"
    min_node_count = "${var.min_node_count}"
  }

  management {
    auto_repair = true
    auto_upgrade = true
  }

  node_config {

    disk_size_gb = "100"
    machine_type = "n1-standard-2"
    image_type = "COS"
    disk_type = "pd-standard"

    preemptible  = "${terraform.workspace != "prod" ? true : false}"

    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/sqlservice.admin",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/pubsub",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/trace.append"
    ]

    labels {
      created-by = "terraform"
      source-cloud = "my-infrastruture"
    }

    // Must be a match of regex '(?:[a-z](?:[-a-z0-9]{0,61}[a-z0-9])?)'
    tags = [
      "created-by-terraform",
      "${var.cluster_name}",
      "source-cloud-my-infrastruture"]
  }
}
