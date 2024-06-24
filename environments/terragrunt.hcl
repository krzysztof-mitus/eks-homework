# stage/terragrunt.hcl
remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "krzysztof-homework-terraform-backend"
    key = "${path_relative_to_include()}/terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    dynamodb_table = "my-lock-table"
  }
}

inputs = {
  region = "eu-central-1"
  homework_app_image_repo = "krzysztof-homework-app"
  homework_app_image_tag = "latest"
  homework_app_chart_name = "homework-app"
  homework_app_chart_version = "0.1.0"

  tags = {
    Name = "Krzysztof"
    Owner = "Nati"
    Department = "DevOps"
    Temp = "True"
  }
}