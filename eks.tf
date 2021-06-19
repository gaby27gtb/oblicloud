##Cluster
resource "aws_eks_cluster" "app-cluster" {
  name     = "app-cluster"
  role_arn = aws_iam_role.eksClusterRole.arn

  vpc_config {
    subnet_ids = [aws_subnet.vpc-subnet-us-east-1a.id, aws_subnet.vpc-subnet-us-east-1b.id]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.eksClusterRole-AmazonEKSClusterPolicy,
   # aws_iam_role_policy_attachment.eksClusterRole-AmazonEKSVPCResourceController,
  ]
}

output "endpoint" {
  value = aws_eks_cluster.app-cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.app-cluster.certificate_authority[0].data
}

##Workers

resource "aws_eks_node_group" "eksWorker" {
  cluster_name    = aws_eks_cluster.app-cluster.name
  node_group_name = "eksWorker"
  node_role_arn   = aws_iam_role.eksWorkerRole.arn
  subnet_ids      = [aws_subnet.vpc-subnet-us-east-1a.id, aws_subnet.vpc-subnet-us-east-1b.id]
  instance_types = ["t3.medium"]

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 2
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.eksWorkerRole-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eksWorkerRole-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eksWorkerRole-AmazonEC2ContainerRegistryReadOnly,
  ]
}