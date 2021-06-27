resource "kubernetes_config_map" "example" {
  metadata {
    name = "my-config"
  }

  data = {
    db_host             = data.aws_db_instance.dbobligatorio.id
    db_name             = "dbobligatorio"
    db_password         = "passwordort"
    db_user             = "ort"
  }
}