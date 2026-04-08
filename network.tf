data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = format("%s-vpc", var.prefix)
  cidr = var.vpc_cidr

  azs             = data.aws_availability_zones.available.names

  public_subnets  = local.public_subnets
  public_subnet_names = [for i in range(length(local.public_subnets)) : "public-subnet-${i + 1}-${var.prefix}"]

  private_subnets = local.private_subnets
  private_subnet_names = [for i in range(length(local.private_subnets)) : "private-subnet-${i + 1}-${var.prefix}"]
  
  intra_subnets   = local.secure_subnets
  intra_subnet_names = [for i in range(length(local.secure_subnets)) : "secure-subnet-${i + 1}-${var.prefix}"]

  enable_nat_gateway = true
  enable_vpn_gateway = true
  single_nat_gateway = true

  public_route_table_tags = {
    Name = format("%s-public-route-table", var.prefix)
  }

  private_route_table_tags = {
    Name = format("%s-private-route-table", var.prefix)
  }

  intra_route_table_tags = {
    Name = format("%s-secure-route-table", var.prefix)
  }

  igw_tags = {
    Name = format("%s-igw", var.prefix)
  }

  nat_gateway_tags = {
    Name = format("%s-nat-gateway", var.prefix)
  }
}