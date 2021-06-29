##Persistent Volume
resource "kubernetes_persistent_volume" "documentos-efs-pv" {
  metadata {
    name = "documentos-efs-pv"
  }
  spec {
    storage_class_name = ""
    persistent_volume_reclaim_policy = "Retain"
    capacity = {
      storage = "2Gi"
    }
    access_modes = ["ReadWriteMany"]
    persistent_volume_source {
      nfs {
        path = "/"
        server = data.terraform_remote_state.eks.outputs.documentos-fs-dns_name
      }
    }
  }
}

##Persistent Volume Claim

resource "kubernetes_persistent_volume_claim" "documentos-efs-pvc" {
  metadata {
    name = "documentos-efs-pvc"
    namespace = kubernetes_namespace.obligatorio-ns.metadata.0.name
  }
  spec {
    storage_class_name = ""
    access_modes = ["ReadWriteMany"]
    resources {
      requests = {
        storage = "2Gi"
      }
    }
    volume_name = "documentos-efs-pv"
  }
}