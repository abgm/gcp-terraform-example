output kubernetes_service_account_tiller_name {
  description = "Service account name for tiller"
  value       = "${module.gke.kubernetes_service_account_tiller_name}"
}
output kubernetes_endpoint {
  value       = "${module.gke.kubernetes_endpoint}"
}
output cluster_ca_certificate {
  value       = "${module.gke.cluster_ca_certificate}"
}
output kubernetes_subnetwork_name {
  value       = "${module.gke.kubernetes_subnetwork_name}"
}
output kubernetes_region {
  value       = "${var.region}"
}
output kubernetes_project {
  value       = "${var.project}"
}