include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../terraform//homework"
}

inputs = {
  env_name = "prod"
  cluster_name = "prod-cluster"
  vpc_cidr = "10.30.0.0/16"
}