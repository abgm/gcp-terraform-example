variable project {
  type = "string"
  description = "The project to deploy to, if not set the default provider project is used."
}
variable "service_name" {
  description = "Name of the datacatalog service to create ( schema-registry-service )"
}

//  network information
variable "region" {
  description = "The region to resources creation"
}
variable "subnetwork" {
  type = "string"
  description = "The name or self_link of the Google Compute Engine subnetwork in which the cluster's instances are launched."
}
variable "dns_managed_zone_name" {
  type = "string"
  description = ""
}
variable "dns_managed_zone_dns_name" {
  type = "string"
  description = ""
}

//  helm services data
variable helm_chart {
  type = "string"
  description = "Directory for the helm chart template ( helm/schema-registry )"
}
variable image_tag {
  type = "string"
  description = "Tag for the docker image to be deployed ( 20190205.991ed57 )"
}

//  database instance variables
variable "cloudsql_instance_name" {
  type = "string"
  description = "cloud sql instance name"
}
variable "cloudsql_instance_address" {
  type = "string"
  description = "cloud sql instance address"
}

// Provider configuration
variable "kubernetes_cluster_endpoint" {
  type = "string"
}
variable "cluster_ca_certificate" {
  type = "string"
}
variable "kubernetes_service_account_tiller" {
  type = "string"
}