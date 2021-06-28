##Persistent Volume
resource "kubernetes_persistent_volume" "documentos-efs-pv" {
  metadata {
    name = "documentos-efs-pv"
  }
  spec {
    storage_class_name = "efs-sc"
    persistent_volume_reclaim_policy = "Retain"
    capacity = {
      storage = "2Gi"
    }
    access_modes = ["ReadWriteMany"]
    persistent_volume_source {
      nfs {
        path = "/"
        server = data.aws_efs_mount_target.documentos-1a.dns_name
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
    access_modes = ["ReadWriteMany"]
    resources {
      requests = {
        storage = "5Gi"
      }
    }
    volume_name = kubernetes_persistent_volume.documentos-efs-pv.metadata.0.name
  }
}