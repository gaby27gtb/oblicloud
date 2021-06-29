resource "kubernetes_deployment" "obligatorio-dp" {
  metadata {
    name = "obligatorio-dp"
    namespace = kubernetes_namespace.obligatorio-ns.metadata.0.name
    labels = {
      Name = "obligatorio-dp"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        name = "obligatorio-dp"
      }
    }

    template {
      metadata {
        labels = {
          name = "obligatorio-dp"
        }
      }

      spec {
        container {
          image = "sogeking27/simple-ecomme:v4"
          name  = "simple-ecomme"
          port {
          container_port = 80
          }
          env {
            name = "dbhost"
            value = data.terraform_remote_state.eks.outputs.db-address
          }
         
          volume_mount {
            name = "documentos-efs-pv"
            mount_path = "/mnt"
          }
        }
        volume {
          persistent_volume_claim {
            claim_name = "documentos-efs-pvc"
          }
        }  
      }
    }
  }
}
  
