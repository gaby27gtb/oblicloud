resource "kubernetes_config_map" "configmap-php" {
  metadata {
    name = "configmap-php"
    namespace = kubernetes_namespace.obligatorio-ns.metadata.0.name
  }

  data = {
    db_host             = data.aws_db_instance.dbobligatorio.address
    db_name             = "dbobligatorio"
    db_password         = "passwordort"
    db_user             = "ort"
  }
}