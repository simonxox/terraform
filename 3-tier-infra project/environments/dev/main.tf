# VPC
module "vpc" {
  source          = "../../modules/vpc"
  vpc_name        = var.vpc_name
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

# Security Groups
module "security_group" {
  source          = "../../modules/security_group"
  vpc_id          = module.vpc.vpc_id
  security_groups = var.security_groups
}

# Launch Templates
module "launch_template" {
  for_each           = var.launch_templates
  source             = "../../modules/launch_template"
  name               = each.value.name
  description        = each.value.description
  ami_id             = each.value.ami_id
  instance_type      = each.value.instance_type
  key_name           = each.value.key_name
  security_group_ids = each.key == "frontend" ? [module.security_group.security_group_ids["alb-frontend-sg"]] : [module.security_group.security_group_ids["alb-backend-sg"]]
}

# Auto Scaling
module "autoscaling" {
  source = "../../modules/autoscaling"

  autoscaling_groups = {
    frontend-asg = merge(
      var.autoscaling_groups["frontend-asg"],
      {
        launch_template_id = module.launch_template["frontend"].launch_template_id,
        subnet_ids         = [module.vpc.public_subnet_ids[0], module.vpc.public_subnet_ids[1]]
      }
    )
    backend-asg = merge(
      var.autoscaling_groups["backend-asg"],
      {
        launch_template_id = module.launch_template["backend"].launch_template_id,
        subnet_ids         = [module.vpc.private_subnet_ids[0], module.vpc.private_subnet_ids[1]]
      }
    )
  }
}

# ALB Frontend
module "alb_frontend" {
  source              = "../../modules/alb_frontend"
  tg_name             = var.frontend_tg_name
  tg_port             = 80
  tg_protocol         = "HTTP"
  vpc_id              = module.vpc.vpc_id
  lb_name             = var.frontend_lb_name
  security_group_ids  = [module.security_group.security_group_ids["alb-frontend-sg"]]
  subnet_ids          = [module.vpc.public_subnet_ids[0], module.vpc.public_subnet_ids[1]]
  listener_port       = 80
  listener_protocol   = "HTTP"
}

# ALB Backend
module "alb_backend" {
  source              = "../../modules/alb_backend"
  tg_name             = var.backend_tg_name
  tg_port             = 80
  tg_protocol         = "HTTP"
  vpc_id              = module.vpc.vpc_id
  lb_name             = var.backend_lb_name
  security_group_ids  = [module.security_group.security_group_ids["alb-backend-sg"]]
  subnet_ids          = [module.vpc.private_subnet_ids[0], module.vpc.private_subnet_ids[1]]
  listener_port       = 80
  listener_protocol   = "HTTP"
}

# RDS
module "rds" {
  source              = "../../modules/rds"
  db_identifier       = var.db_identifier
  subnet_group_name   = var.subnet_group_name
  db_subnet_ids       = [module.vpc.private_subnet_ids[0], module.vpc.private_subnet_ids[1]]
  allocated_storage   = 20
  db_name             = var.db_name
  db_username         = var.db_username
  db_password         = var.db_password
  instance_class      = "db.t3.micro"
  engine              = "mysql"
  engine_version      = "8.0.32"
  multi_az            = true
  security_group_ids  = [module.security_group.security_group_ids["rds"]]
  backup_retention    = 7
}

# Bastion
module "bastion" {
  source             = "../../modules/bastion"
  ami                = var.bastion_ami
  instance_type      = var.bastion_instance_type
  key_name           = var.bastion_key_name
  subnet_id          = module.vpc.public_subnet_ids[0]
  security_group_ids = [module.security_group.security_group_ids["bastion-host"]]
  name               = "bastion-server"
}
