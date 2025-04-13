variable "lb_name" {
  default = "my-alb"
}

variable "internal" {
  default = false
}

variable "load_balancer_type" {
  default = "application"
}

variable "security_groups" {
  default = []
}

variable "subnets" {
  default = []
}

variable "enable_deletion_protection" {
  default = false
}

variable "tg_name" {
  default = "my-tg"
}

variable "tg_port" {
  default = 80
}

variable "tg_protocol" {
  default = "HTTP"
}

variable "vpc_id" {
  default = ""
}

variable "health_check_path" {
  default = "/"
}

variable "health_check_protocol" {
  default = "HTTP"
}

variable "health_check_port" {
  default = "traffic-port"
}

variable "listener_port" {
  default = 80
}

variable "listener_protocol" {
  default = "HTTP"
}
