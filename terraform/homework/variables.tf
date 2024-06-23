variable "env_name" {
    description = "Environment name"
    type = string
    default = ""
}

variable "cluster_name" {
    description = "EKS cluster name"
    type = string
    default = ""
}

variable "vpc_cidr" {
    description = "VPC CIDR block"
    type = string
    default = "10.0.0.0/16"
}

variable "region" {
    description = "AWS region"
    type = string
    default = "eu-central-1"
}

variable "tags" {
    description = "Tags to apply to all resources"
    type = map(string)
    default = {}
  
}
