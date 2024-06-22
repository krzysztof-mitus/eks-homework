module "lb_role" {
    source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
    role_name                              = "${var.env_name}_eks_lb"
    attach_load_balancer_controller_policy = true
    oidc_providers = {
        main = {
            provider_arn               = module.eks.oidc_provider_arn
            namespace_service_accounts = ["kube-system:aws-load-balancer-controller"]
        }
    }
}

data "aws_eks_cluster" "this" {
  name = "${var.name}-cluster"
}

data "aws_eks_cluster_auth" "this" {
  name = "${var.name}-cluster"
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.this.token
}


resource "kubernetes_service_account" "service-account" {
    metadata {
        name      = "aws-load-balancer-controller"
        namespace = "kube-system"
        labels = {
            "app.kubernetes.io/name"      = "aws-load-balancer-controller"
            "app.kubernetes.io/component" = "controller"
        }
        annotations = {
            "eks.amazonaws.com/role-arn"               = module.lb_role.iam_role_arn
            "eks.amazonaws.com/sts-regional-endpoints" = "true"
        }
    }
}

resource "helm_release" "alb-controller" {
    name       = "aws-load-balancer-controller"
    repository = "https://aws.github.io/eks-charts"
    chart      = "aws-load-balancer-controller"
    namespace  = "kube-system"
    depends_on = [
        kubernetes_service_account.service-account
    ]

    set {
        name  = "region"
        value = var.region
    }

    set {
        name  = "vpcId"
        value = module.vpc.vpc_id
    }

    set {
        name  = "image.repository"
        value = "602401143452.dkr.ecr.${var.region}.amazonaws.com/amazon/aws-load-balancer-controller"
    }

    set {
        name  = "serviceAccount.create"
        value = "false"
    }

    set {
        name  = "serviceAccount.name"
        value = "aws-load-balancer-controller"
    }

    set {
        name  = "clusterName"
        value = var.name
    }
}