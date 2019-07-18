resource "google_compute_global_address" "private_ip_address" {
    provider = "google-beta"
    project = "${var.project}"
    name          = "private-ip-address"
    purpose       = "VPC_PEERING"
    address_type = "INTERNAL"
    prefix_length = 16
    network       = "${var.vpc}"
}

resource "google_service_networking_connection" "private_vpc_connection" {
    provider = "google-beta"
    network       = "${var.vpc}"
    service       = "servicenetworking.googleapis.com"
    reserved_peering_ranges = ["${google_compute_global_address.private_ip_address.name}"]
}
