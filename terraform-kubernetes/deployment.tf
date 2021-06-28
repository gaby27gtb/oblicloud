resource "kubernetes_deployment" "obligatorio-dp" {
  metadata {
    name = "obligatorio-dp"
    namespace = kubernetes_namespace.obligatorio-ns.metadata.0.name
    labels = {
      Name = "obligatorio-dp"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        Name = "obligatorio-dp"
      }
    }

    template {
      metadata {
        labels = {
          Name = "obligatorio-dp"
        }
      }

      spec {
        container {
          image = "sogeking27/simple-ecomme:v2"
          name  = "simple-ecomme"

          /*resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
          /*volume_mount {
            name = "documentos-efs-pv"
            mount_path = "/"
          }*/
        }
        /*volume {
          kubernetes_persistent_volume_claim = 
        }*/
      }
    }
  }
}