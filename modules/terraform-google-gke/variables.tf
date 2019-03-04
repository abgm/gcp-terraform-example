variable project {
  type = "string"
  description = "The project to deploy to, if not set the default provider project is used."
}
variable "cluster_name" {
  type = "string"
  description = "Cluster name for the GCP Cluster."
}
variable "region" {
  type = "string"
  description = "The region to host the cluster in"
}
variable "network" {
  type = "string"
  description = "The name or self_link of the Google Compute Engine network to which the cluster is connected. For Shared VPC, set this to the self link of the shared network."
}
variable "initial_node_count" {
  type = "string"
  default = "1"
  description = "(Optional) The initial node count for the pool. Changing this will force recreation of the resource"
}
variable "min_node_count" {
  type = "string"
  default = "1"
  description = "Minimum number of nodes in the NodePool. Must be >=1 and <= max_node_count."
}
variable "max_node_count" {
  type = "string"
  default = "5"
  description = "Maximum number of nodes in the NodePool. Must be >= min_node_count."
}
variable "master_ipv4_cidr_block" {
}
