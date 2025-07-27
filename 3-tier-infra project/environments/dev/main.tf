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
  lt_name_prefix     = each.value.name
  ami_id             = each.value.ami_id
  instance_type      = each.value.instance_type
  key_name           = each.value.key_name
  security_group_ids = each.key == "frontend" ? [module.security_group.security_group_ids["alb-frontend-sg"]] : [module.security_group.security_group_ids["alb-backend-sg"]]
  user_data          = "" # Optional: replace with file("${path.module}/userdata.sh") if needed
}

# Auto Scaling Groups
module "autoscaling" {
  source = "../../modules/autoscaling"

  asg_configs = {
    frontend-asg = {
      launch_template_id      = module.launch_template["frontend"].launch_template_id
      launch_template_version = var.autoscaling_groups["frontend-asg"].launch_template_version
      subnet_ids              = [module.vpc.private_subnet_ids[2], module.vpc.private_subnet_ids[3]] # 🛡️ Moved to private subnet
      desired_capacity        = var.autoscaling_groups["frontend-asg"].desired_capacity
      max_size                = var.autoscaling_groups["frontend-asg"].max_size
      min_size                = var.autoscaling_groups["frontend-asg"].min_size
      tag_name                = var.autoscaling_groups["frontend-asg"].tag_name
      target_group_arns       = [module.alb_frontend.target_group_arn]
    }

    backend-asg = {
      launch_template_id      = module.launch_template["backend"].launch_template_id
      launch_template_version = var.autoscaling_groups["backend-asg"].launch_template_version
      subnet_ids              = [module.vpc.private_subnet_ids[0], module.vpc.private_subnet_ids[1]]
      desired_capacity        = var.autoscaling_groups["backend-asg"].desired_capacity
      max_size                = var.autoscaling_groups["backend-asg"].max_size
      min_size                = var.autoscaling_groups["backend-asg"].min_size
      tag_name                = var.autoscaling_groups["backend-asg"].tag_name
      target_group_arns       = [module.alb_backend.target_group_arn]
    }
  }
}

# ALB Frontend
module "alb_frontend" {
  source              = "../../modules/alb_frontend"
  tg_name             = var.frontend_tg_name
  tg_port             = var.frontend_tg_port
  tg_protocol         = var.frontend_tg_protocol
  vpc_id              = module.vpc.vpc_id
  lb_name             = var.frontend_lb_name
  security_group_ids  = [module.security_group.security_group_ids["alb-frontend-sg"]]
  subnet_ids          = [module.vpc.public_subnet_ids[0], module.vpc.public_subnet_ids[1]]
  listener_port       = var.frontend_listener_port
  listener_protocol   = var.frontend_listener_protocol
}

# ALB Backend
module "alb_backend" {
  source              = "../../modules/alb_backend"
  tg_name             = var.backend_tg_name
  tg_port             = var.backend_tg_port
  tg_protocol         = var.backend_tg_protocol
  vpc_id              = module.vpc.vpc_id
  lb_name             = var.backend_lb_name
  security_group_ids  = [module.security_group.security_group_ids["alb-backend-sg"]]
  subnet_ids          = [module.vpc.private_subnet_ids[0], module.vpc.private_subnet_ids[1]]
  listener_port       = var.backend_listener_port
  listener_protocol   = var.backend_listener_protocol
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
  instance_class      = var.db_instance_class
  engine              = var.db_engine
  engine_version      = var.db_engine_version
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
