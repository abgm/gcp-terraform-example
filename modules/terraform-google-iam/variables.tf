variable project {
  type = "string"
  description = "The project to deploy to, if not set the default provider project is used."
}
variable account_id {
  type = "string"
  description = "Id for the service account"
}
variable display_name {
  type = "string"
  description = "Id for the service account"
  default = "Global Account for access to cloud sql"
}