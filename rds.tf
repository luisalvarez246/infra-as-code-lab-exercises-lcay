module "rds" {
  source = "./modules/storage/"

  prefix          = var.prefix
  region          = var.region
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.intra_subnets
  security_groups = [module.ecs.ecs_security_group_id]
  db_username     = var.db_username
  db_name         = var.db_name
}