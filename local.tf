locals {
  public_subnets  = [for i in range(0, var.number_of_public_subnets) : cidrsubnet(var.vpc_cidr, 3, i)]
  private_subnets = [for i in range(0, var.number_of_private_subnets) : cidrsubnet(var.vpc_cidr, 3, i + var.number_of_public_subnets)]
  secure_subnets  = [for i in range(0, var.number_of_secure_subnets) : cidrsubnet(var.vpc_cidr, 3, i + var.number_of_public_subnets + var.number_of_private_subnets)]
}