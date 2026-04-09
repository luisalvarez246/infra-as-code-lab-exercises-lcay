variable "prefix" {
  type        = string
  description = "Short, unique lowercase prefix for resource names."
}

variable "region" {
  type        = string
  description = "AWS region to deploy resources (e.g. us-east-1)."
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where resources will be deployed."
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs where resources will be deployed."
}

variable "security_groups" {
  type        = list(string)
  description = "List of security group IDs to associate with resources."
}

variable "db_username" {
  type        = string
  description = "Database username."
}

variable "db_name" {
  type        = string
  description = "Database name."
}
