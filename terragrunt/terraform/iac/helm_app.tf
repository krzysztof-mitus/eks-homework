data "aws_caller_identity" "current" {}
data "aws_ecr_authorization_token" "token" {}

resource "helm_release" "homework" {
    name       = "homework-app"
    chart      = "homework-app"
    namespace  = "homework"    
    repository = "oci://${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com"
    repository_username = data.aws_ecr_authorization_token.token.user_name
    repository_password = data.aws_ecr_authorization_token.token.password    

    create_namespace = true
    
    values = [
        "${file("helm-values/homework-app/values.yaml")}"
    ]
    
    set {
        name = "image.registry"
        value = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com"
    }
}