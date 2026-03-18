variable "prefix" {
  type        = string
  description = "Short, unique lowercase prefix for resource names."
}

variable "region" {
  type        = string
  description = "AWS region to deploy resources (e.g. us-east-1)."
}
