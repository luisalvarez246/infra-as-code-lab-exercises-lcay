locals {
  az_names = data.aws_availability_zones.available.names

  public_subnets = {
    for i in range(0, var.number_of_public_subnets) :
    i => {
      cidr = cidrsubnet(var.vpc_cidr, 3, i)
      az   = element(local.az_names, i)
    }
  }

  private_subnets = {
    for i in range(0, var.number_of_private_subnets) :
    i => {
      cidr = cidrsubnet(var.vpc_cidr, 3, i + var.number_of_public_subnets)
      az   = element(local.az_names, i)
    }
  }

  secure_subnets = {
    for i in range(0, var.number_of_secure_subnets) :
    i => {
      cidr = cidrsubnet(var.vpc_cidr, 3, i + var.number_of_public_subnets + var.number_of_private_subnets)
      az   = element(local.az_names, i)
    }
  }
}