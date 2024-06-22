variable "vpc_cidr" {
  type = string
  default = "10.20.0.0/16"
}

variable "name" {
    type = string
    default = "homework"
  
}

variable "env_name" {
    type = string
    default = "DEV"
  
}

variable "region" {
    type = string
    default = "eu-central-1"
  
}