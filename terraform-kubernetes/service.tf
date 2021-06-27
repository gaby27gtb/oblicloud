resource "kubernetes_service" "obligatorio-service" {
  metadata {
    name = "obligatorio-service"
    namespace = kubernetes_namespace.obligatorio-ns.metadata.0.name
  }
  spec {
    selector = {
      App = kubernetes_deployment.obligatorio-dp.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}