resource "kubernetes_service" "obligatorio-service" {
  metadata {
    name = "obligatorio-service"
    namespace = kubernetes_namespace.obligatorio-ns.metadata.0.name
  }
  spec {
    selector = {
      name = "obligatorio-dp"
    }
    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}