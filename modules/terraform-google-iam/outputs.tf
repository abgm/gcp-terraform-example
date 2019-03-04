output "private_key" {
    description     = "Private key from service account"
    value           = "${base64decode(google_service_account_key.default.private_key)}"
    sensitive       = true
}