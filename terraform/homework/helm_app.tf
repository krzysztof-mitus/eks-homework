data "aws_caller_identity" "current" {}
data "aws_ecr_authorization_token" "token" {}

resource "helm_release" "homework-app" {
    depends_on = [helm_release.alb-controller]
    name       = var.homework_app_chart_name
    chart      = var.homework_app_chart_name
    version    = var.homework_app_chart_version
    namespace  = "homework"    
    repository = "oci://${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com"
    repository_username = data.aws_ecr_authorization_token.token.user_name
    repository_password = data.aws_ecr_authorization_token.token.password    

    create_namespace = true
    
    set {
        name = "image.registry"
        value = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com"
    }

    set {
        name = "image.repository"
        value = var.homework_app_image_repo
    }

    set {
        name = "image.tag"
        value = var.homework_app_image_tag
    }

    set {
      name = "env.CLUSTER_ENV"
      value = var.env_name
    }
}