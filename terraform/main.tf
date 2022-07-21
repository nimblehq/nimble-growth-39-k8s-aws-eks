# VPC
module "vpc" {
  source = "./modules/vpc"

  namespace = var.namespace
}

# Security groups
module "security_group" {
  source = "./modules/security_group"

  namespace                   = var.namespace
  vpc_id                      = module.vpc.vpc_id
  app_port                    = var.app_port
  private_subnets_cidr_blocks = module.vpc.private_subnets_cidr_blocks
}

# ECR
module "ecr" {
  source = "./modules/ecr"

  namespace   = var.namespace
  image_limit = var.image_limit
}

# Log
module "log" {
  source = "./modules/log"

  namespace = var.namespace
}

# S3
module "s3" {
  source = "./modules/s3"

  namespace = var.namespace
}

# RDS
module "rds" {
  source = "./modules/rds"

  namespace = var.namespace

  vpc_security_group_ids = module.security_group.rds_security_group_ids
  vpc_id                 = module.vpc.vpc_id

  subnet_ids = module.vpc.private_subnet_ids

  instance_type = var.rds_instance_type
  database_name = var.rds_database_name
  username      = var.rds_username
  password      = var.rds_password

  autoscaling_min_capacity = var.rds_autoscaling_min_capacity
  autoscaling_max_capacity = var.rds_autoscaling_max_capacity
}

# SSM
module "ssm" {
  source = "./modules/ssm"

  namespace       = var.namespace
  secret_key_base = var.secret_key_base

  rds_username      = var.rds_username
  rds_password      = var.rds_password
  rds_database_name = var.rds_database_name
  rds_endpoint      = module.rds.db_endpoint
}

# EKS
module "eks" {
  source = "./modules/eks"

  namespace  = var.namespace
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnet_ids
}
