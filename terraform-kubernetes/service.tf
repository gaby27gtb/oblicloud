resource "kubernetes_service" "obligatorio-service" {
  metadata {
    name = "obligatorio-service"
    namespace = kubernetes_namespace.obligatorio-ns.metadata.0.name
  }
  spec {
    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}