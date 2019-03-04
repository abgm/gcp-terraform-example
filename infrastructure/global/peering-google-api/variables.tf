variable project {
  description   = "The project to deploy to, if not set the default provider project is used."
}

variable vpc {
  type = "string"
  default = ""
}
