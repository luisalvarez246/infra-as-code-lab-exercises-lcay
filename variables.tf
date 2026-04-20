variable "prefix" {
  type        = string
  description = "Short, unique lowercase prefix for resource names."
}

variable "region" {
  type        = string
  description = "AWS region to deploy resources (e.g. us-east-1)."
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block"
}

variable "number_of_public_subnets" {
  type        = number
  description = "Number of public subnets to create."
}

variable "number_of_private_subnets" {
  type        = number
  description = "Number of private subnets to create."
}

variable "number_of_secure_subnets" {
  type        = number
  description = "Number of secure subnets to create."
}

variable "db_username" {
  type        = string
  description = "Database username"
}

variable "db_name" {
  type        = string
  description = "Database name"
}