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
    Name = "Krzysztof"
    Owner = "Nati"
    Department = "DevOps"
    Temp = "True"
    keep = "3"
  }
  vpc_cidr = "10.10.0.0/16"
}
