variable "cluser_name" {
  default = "fargate_cluster"
}

variable "service_name" {
  default = "fargate_servise"
}

variable "cluster_id" {
  default = []
}

variable "task_definition_id" {
  default = ""
}

variable "launch_type" {
  default = "FARGATE"
}

variable "service_subnets" {
  default = []
}

variable "service_security_groups" {
  default = []
}

variable "target_group_arn" {}

variable "container_name" {}

variable "container_port" {}
