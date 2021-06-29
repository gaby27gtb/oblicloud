resource "null_resource" "install_efs_csi_driver" {
  provisioner "local-exec" {
    command = format("aws eks --region us-east-1 update-kubeconfig --name app-cluster")
  }
  provisioner "local-exec" {
    command = format("kubectl --kubeconfig %s apply -k 'github.com/kubernetes-sigs/aws-efs-csi-driver/deploy/kubernetes/overlays/stable/?ref=release-1.1'", module.eks.kubeconfig_filename)
  }

depends_on = [
    aws_eks_cluster.app-cluster
]
}