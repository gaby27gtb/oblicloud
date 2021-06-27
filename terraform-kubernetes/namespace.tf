resource "kubernetes_namespace" "obligatorio-ns" {
  metadata {
    name = "obligatorio-ns"
  }
}