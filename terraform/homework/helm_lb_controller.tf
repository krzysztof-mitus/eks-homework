locals {
    name = "aws-load-balancer-controller"
}

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

resource "kubernetes_service_account" "service-account" {
    depends_on = [module.eks]
    metadata {
        name      = local.name
        namespace = "kube-system"
        labels = {
            "app.kubernetes.io/name"      = local.name
            "app.kubernetes.io/component" = "controller"
        }
        annotations = {
            "eks.amazonaws.com/role-arn"               = module.lb_role.iam_role_arn
            "eks.amazonaws.com/sts-regional-endpoints" = "true"
        }
    }
}

resource "helm_release" "alb-controller" {
    depends_on = [kubernetes_service_account.service-account]
    name       = local.name
    repository = "https://aws.github.io/eks-charts"
    chart      = local.name
    namespace  = "kube-system"
    
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
        value = "602401143452.dkr.ecr.${var.region}.amazonaws.com/amazon/${local.name}"
    }

    set {
        name  = "serviceAccount.create"
        value = "false"
    }

    set {
        name  = "serviceAccount.name"
        value = local.name
    }

    set {
        name  = "clusterName"
        value = var.cluster_name
    }
}