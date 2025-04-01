terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# Create Security Groups
module "sg" {
  source          = "./modules/sg"
  vpc_id          = var.vpc_id
  security_groups = var.security_groups
  common_tags     = var.common_tags
}

# Compute Resources (Private, Application, and Public instances)
module "compute" {
  source                  = "./modules/compute"
  vpc_id                  = var.vpc_id
  selected_private_subnet = var.selected_private_subnet
  selected_public_subnet  = var.selected_public_subnet
  availability_zones      = var.availability_zones
  private_servers         = var.private_servers
  applications            = var.applications
  public_instances        = var.public_instances
  common_iam_role         = var.common_iam_role
  common_tags             = var.common_tags
  vpc_security_group_ids  = module.sg.sg_ids
}

# ALB Module for Application Servers
module "alb" {
  source                  = "./modules/alb"
  vpc_id                  = var.vpc_id
  subnets                 = var.private_subnets    # ALB is internal so use private subnets
  applications            = var.applications
  app_instance_ids        = module.compute.application_instances
  alb_security_group_ids  = [ module.sg.sg_ids["alb-sg"] ]  # "alb-sg" must be defined in security groups
  app_port                = 80
  common_tags             = var.common_tags
}

# EFS Module
module "efs" {
  source              = "./modules/efs"
  vpc_id              = var.vpc_id
  private_subnets     = var.private_subnets
  efs                 = var.efs
  common_tags         = var.common_tags
  environment         = var.environment
  efs_security_groups = var.efs_security_groups
}

# RDS MySQL Module (Production Only)
module "rds" {
  source         = "./modules/rds"
  vpc_id         = var.vpc_id
  private_subnets = var.private_subnets
  rds_mysql      = var.rds_mysql
  common_tags    = var.common_tags
  environment    = var.environment
  db_username    = var.db_username
  db_password    = var.db_password
}

# Backup & Observability Module (Production Only)
module "backup" {
  source                   = "./modules/backup"
  backup_and_observability = var.backup_and_observability
  common_tags              = var.common_tags
  environment              = var.environment
}
