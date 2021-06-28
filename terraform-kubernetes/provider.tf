terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.20.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.1"
    }
  }
}

data "terraform_remote_state" "eks" {
  backend = "local"

  config = {
    path = "/home/pablo/ORT/oblicloud/terraform.tfstate"
  }
}

# Retrieve EKS cluster information
provider "aws" {
  region = "us-east-1"
}

/*data "aws_efs_mount_target" "documentos-1a" {
}
*/
data "aws_db_instance" "dbobligatorio" {
   db_instance_identifier = data.terraform_remote_state.eks.outputs.db-id
}

data "aws_eks_cluster" "app-cluster" {
  name = "app-cluster"
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.app-cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.app-cluster.certificate_authority.0.data)
  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    command     = "aws"
    args = [
      "eks",
      "get-token",
      "--cluster-name",
      data.aws_eks_cluster.app-cluster.name
    ]
  }
}