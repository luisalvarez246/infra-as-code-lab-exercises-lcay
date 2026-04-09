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

variable "subnet1_cidr" {
  type        = string
  description = "CIDR block for subnet 1 (e.g. 10.0.1.0/24)."
}
variable "subnet2_cidr" {
  type        = string
  description = "CIDR block for subnet 2 (e.g. 10.0.2.0/24)."
}
variable "subnet3_cidr" {
  type        = string
  description = "CIDR block for subnet 3 (e.g. 10.0.3.0/24)."
}
variable "subnet4_cidr" {
  type        = string
  description = "CIDR block for subnet 4 (e.g. 10.0.4.0/24)."
}
variable "subnet5_cidr" {
  type        = string
  description = "CIDR block for subnet 5 (e.g. 10.0.5.0/24)."
}
variable "subnet6_cidr" {
  type        = string
  description = "CIDR block for subnet 6 (e.g. 10.0.6.0/24)."
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