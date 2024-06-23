include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../terraform//homework"
}

inputs = {
  env_name = "dev"
  cluster_name = "dev-cluster"
  tags = {
    Environment = "Development"
    Owner = "Krzysztof"
  }
  vpc_cidr = "10.10.0.0/16"
}