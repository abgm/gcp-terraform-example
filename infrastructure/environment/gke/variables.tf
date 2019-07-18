// pls use export GOOGLE_CREDENTIALS=<path>\credential.json
variable project {
  description   = "The project to deploy to, if not set the default provider project is used."
}
variable "region" {
  type = "string"
  description = "The region to host the cluster in"
}
variable "network" {
  description = "The VPC network to host the cluster in"
}
variable "master_ipv4_cidr_block" {
}
