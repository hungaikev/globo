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

variable "subnet1_address_space" {
  default = "10.1.0.0/24"
}

variable "subent2_address_space" {
  default = "10.1.1.0/24"
}