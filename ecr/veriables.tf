variable "docker-image" {
  default = ""
}

variable "region" {
  default = "eu-central-1"
}

variable "ecr_name" {
  default = ""
}

variable "lifecycle_tag_status" {
  default = "any"
}

variable "lifecycle_count_type" {
  default = "sinceImagePushed"
}

variable "lifecycle_count_number" {
  default = 7
}

variable "lifecycle_description" {
  default = "delete images"
}
