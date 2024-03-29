variable "aws_region" {
  default = "eu-central-1"
}

variable "private_key_path" {}

variable "key_name" {
  default = "kafka_cluster"
}

variable "network_address_space" {
  default = "10.1.0.0/16"
}

variable "instance_count" {
  default = 3
}

variable "subnet_count" {
  default = 2
}

variable "subnet1_address_space" {
  default = "10.1.0.0/24"
}

variable "subent2_address_space" {
  default = "10.1.1.0/24"
}

variable "bucket_name_prefix" {}

variable "billing_code_tag" {}

variable "environment_tag" {}
