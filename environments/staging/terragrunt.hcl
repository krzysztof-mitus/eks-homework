include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../terraform//homework"
}

inputs = {
  env_name = "staging"
  cluster_name = "staging-cluster"
  tags = {
    Name = "Krzysztof"
    Owner = "Nati"
    Department = "DevOps"
    Temp = "True"
    Environment = "Staging"
  }
  vpc_cidr = "10.20.0.0/16"
}