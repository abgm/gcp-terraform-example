resource "kubernetes_service_account" "tiller" {
  depends_on = ["google_container_node_pool.default"]
  metadata {

    name = "tiller"

    namespace = "kube-system"

  }

}

resource "kubernetes_cluster_role_binding" "tiller" {
  depends_on = [
    "kubernetes_service_account.tiller"
  ]

  metadata {

    name = "tiller-admin"

  }

  subject {

    kind = "ServiceAccount"

    name = "tiller"

    namespace = "kube-system"

    api_group = ""

  }

  role_ref {

    api_group = "rbac.authorization.k8s.io"

    kind = "ClusterRole"

    name = "cluster-admin"

  }

}
