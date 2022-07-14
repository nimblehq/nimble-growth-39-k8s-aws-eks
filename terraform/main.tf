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

  nimble_office_ip = var.nimble_office_ip
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

# ALB
module "alb" {
  source = "./modules/alb"

  vpc_id             = module.vpc.vpc_id
  namespace          = var.namespace
  app_port           = var.app_port
  subnet_ids         = module.vpc.public_subnet_ids
  security_group_ids = module.security_group.alb_security_group_ids
  health_check_path  = var.health_check_path
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

# Bastion instance
module "bastion" {
  source = "./modules/bastion"

  subnet_ids                  = module.vpc.public_subnet_ids
  instance_security_group_ids = module.security_group.bastion_security_group_ids

  namespace     = var.namespace
  image_id      = var.bastion_image_id
  instance_type = var.bastion_instance_type

  min_instance_count     = var.bastion_min_instance_count
  max_instance_count     = var.bastion_max_instance_count
  instance_desired_count = var.bastion_instance_desired_count
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
