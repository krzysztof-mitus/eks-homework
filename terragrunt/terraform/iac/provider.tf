terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.55.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.31.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = "~> 2.14.0"
    }
  }
}

provider "aws" {
  # Configuration options
  # assume_role {
  #   role_arn     = "arn:aws:iam::329082085800:role/EKSAndVPCRoleForKrzysztof"
  #   session_name = "TerraformEKS"
  # }
  profile = "home"

  default_tags {
    tags = {
      Environment = "Development"
      Owner       = "Krzysztof"
    }
  }
}   

provider "kubernetes" {
  host                   = data.aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.this.token
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.this.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.this.token
  }
}