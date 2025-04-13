variable "family" {
  default = "back_task"
}

variable "network_mode" {
  default = "awsvpc"
}

variable "requires_compatibilities" {
  default = ["FARGATE"]
}

variable "cpu" {
  default = "512"
}

variable "memory" {
  default = "1024"
}

variable "execution_role_arn" {
  default = ""
}

variable "container_name" {
  default = "my-container"
}

variable "container_image" {
  default = "nimmis/alpine-apache"
}

variable "container_cpu" {
  type    = number
  default = 512
}

variable "container_memory" {
  type    = number
  default = 1024
}

variable "essential" {
  default = true
}

variable "container_port" {
  default = 8080
}

variable "host_port" {
  default = 8080
}

variable "log_name" {
  default = ""
}

variable "task_role_arn" {
  default = ""
}


variable "task_command" {
  default = []
}
