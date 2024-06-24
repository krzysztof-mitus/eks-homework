  
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "${var.cluster_name}"
  cluster_version = "1.30"

  # EKS Addons
  cluster_addons = {
    coredns                = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  cluster_endpoint_public_access = true
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  enable_cluster_creator_admin_permissions = true
  iam_role_additional_policies = {
      "additional" = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  eks_managed_node_groups = {
    Krzysztof = {
      
      ami_type       = "AL2_x86_64"
      instance_types = ["t3.medium", "t3.large", "t3.xlarge"]
      capacity_type  = "SPOT"
      metadata_options = {
        http_endpoint = "enabled"
        http_tokens = "required"
        HttpPutResponseHopLimit = 2
      }

      min_size = 1
      max_size = 3
      desired_size = 1

      tags = var.tags

    }
  }
}
