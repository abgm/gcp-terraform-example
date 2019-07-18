output kubernetes_service_account_tiller_name {
  description = "Service account name for tiller"
  value       = "${kubernetes_service_account.tiller.metadata.0.name}"
}
output kubernetes_endpoint {
  value       = "${google_container_cluster.default.endpoint}"
}
output kubernetes_subnetwork_name {
  value       = "${google_container_cluster.default.ip_allocation_policy.0.subnetwork_name}"
}
output cluster_ca_certificate {
  value       = "${google_container_cluster.default.master_auth.0.cluster_ca_certificate}"
}
