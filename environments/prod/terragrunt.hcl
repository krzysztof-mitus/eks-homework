include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../terraform//homework"
}

inputs = {
  env_name = "prod"
  cluster_name = "prod-cluster"
  tags = {
    Name = "Krzysztof"
    Owner = "Nati"
    Department = "DevOps"
    Temp = "True"
    Environment = "Production"
  }
  vpc_cidr = "10.30.0.0/16"
}