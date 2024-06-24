include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../terraform//homework"
}

inputs = {
  env_name = "staging"
  cluster_name = "staging-cluster"
  vpc_cidr = "10.20.0.0/16"
}