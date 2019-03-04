output instance_name {
    description = "The name of the database instance"
    value       = "${module.sql-db.instance_name}"
}

output instance_address {
    description = "The IPv4 address of the master database instnace"
    value       = "${module.sql-db.instance_address}"
}

output instance_address_time_to_retire {
    description = "The time the master instance IP address will be reitred. RFC 3339 format."
    value       = "${module.sql-db.instance_address_time_to_retire}"
}

output self_link {
    description = "Self link to the master instance"
    value       = "${module.sql-db.self_link}"
}