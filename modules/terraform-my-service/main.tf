resource "random_id" "user-password" {
  byte_length = 8
}

resource "google_sql_database" "default" {
  project = "${var.project}"
  name = "${var.service_name}-db"
  instance = "${var.cloudsql_instance_name}"
  charset = "UTF8"
}

resource "google_sql_user" "default" {
  project = "${var.project}"
  name = "${var.service_name}-user"
  instance = "${var.cloudsql_instance_name}"
  password = "${random_id.user-password.hex}"
}

resource "kubernetes_secret" "default" {
  metadata {
    name = "postgres-${var.service_name}"
  }
  data {
    POSTGRES_USERNAME = "${var.service_name}-user"
    POSTGRES_PASSWORD = "${random_id.user-password.hex}"
  }
}

resource "google_compute_address" "service-ilb" {
  project = "${var.project}"
  region = "${var.region}"
  name = "${terraform.workspace}-${var.service_name}-ilb"
  subnetwork = "${var.subnetwork}"
  address_type = "INTERNAL"
}

resource "null_resource" "pre-helm" {
  provisioner "local-exec" {
    command = "bash -c 'cd ${var.helm_chart} && rm requirements.lock | echo 0 && helm dependency up . && helm dependency build .'"
  }
}

resource "helm_release" "helm-service" {

  depends_on = [
    "null_resource.pre-helm"
  ]

  name = "${var.service_name}"
  chart = "${var.helm_chart}"

  timeout = "600"

  set {
    name = "service.loadBalancerIP"
    value = "${google_compute_address.service-ilb.address}"
  }

  set {
    name = "image.tag"
    value = "${var.image_tag}"
  }
  set {
    name = "database.name"
    value = "${google_sql_database.default.name}"
  }
  set {
    name = "database.secret.name"
    value = "${kubernetes_secret.default.metadata.0.name}"
  }
  set {
    name = "database.url"
    value = "${var.cloudsql_instance_address}"
  }
  //  set {
  //    name = "instance.database.secret.user"
  //    value = "${keys(kubernetes_secret.postgres-secret.data)}"
  //  }
  //
  //  set {
  //    name = "instance.database.secret.password"
  //    value = "${keys(kubernetes_secret.postgres-secret.data)}"
  //  }

  values = []
}

resource "google_dns_record_set" "local" {
  project = "${var.project}"
  name = "${terraform.workspace}.${var.service_name}.${var.dns_managed_zone_dns_name}"
  type = "A"
  ttl = 300
  managed_zone = "${var.dns_managed_zone_name}"
  rrdatas = [
    "${google_compute_address.service-ilb.address}"]
}
