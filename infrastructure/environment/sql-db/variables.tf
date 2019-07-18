variable project {
  description   = "The project to deploy to, if not set the default provider project is used."
}
variable "region" {
  description = "The region to host the cluster in"
}
variable network {
  type = "string"
}