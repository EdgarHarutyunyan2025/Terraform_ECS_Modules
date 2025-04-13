variable "region" {
  default = "eu-central-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "vpc_name" {
  default = "PROD"
}

variable "public_subnet_cidrs" {
  default = []
}


variable "private_subnet_cidrs" {
  default = []
}

variable "az_index" {
  default = 0
}
