
module "vpc" {
  source = "../../modules/vpc"
  vpc_name   = var.vpc_name
  vpc_cidr   = var.vpc_cidr
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
}

module "security_group" {
  source = "../../modules/security_group"
  vpc_id = module.vpc.vpc_id
  security_groups = var.security_groups
}

module "launch_template" {
  source = "../../modules/launch_template"
  launch_templates = var.launch_templates
}

module "autoscaling" {
  source = "../../modules/autoscaling"
  autoscaling_groups = var.autoscaling_groups
}

module "alb_frontend" {
  source = "../../modules/alb_frontend"
  tg_name           = var.frontend_tg_name
  tg_port           = 80
  tg_protocol       = "HTTP"
  vpc_id            = module.vpc.vpc_id
  lb_name           = var.frontend_lb_name
  security_group_ids = [module.security_group.security_group_ids["alb-frontend-sg"]]
  subnet_ids         = [for k, v in var.public_subnets : v.cidr]
  listener_port     = 80
  listener_protocol = "HTTP"
}

module "alb_backend" {
  source = "../../modules/alb_backend"
  tg_name           = var.backend_tg_name
  tg_port           = 80
  tg_protocol       = "HTTP"
  vpc_id            = module.vpc.vpc_id
  lb_name           = var.backend_lb_name
  security_group_ids = [module.security_group.security_group_ids["alb-backend-sg"]]
  subnet_ids         = [for k, v in var.public_subnets : v.cidr]
  listener_port     = 80
  listener_protocol = "HTTP"
}

module "rds" {
  source = "../../modules/rds"
  db_identifier         = var.db_identifier
  subnet_group_name     = var.subnet_group_name
  db_subnet_ids         = [for k, v in var.private_subnets : v.cidr]
  allocated_storage     = 20
  db_name               = var.db_name
  db_username           = var.db_username
  db_password           = var.db_password
  instance_class        = "db.t3.micro"
  engine                = "mysql"
  engine_version        = "8.0.32"
  multi_az              = true
  security_group_ids    = [module.security_group.security_group_ids["rds"]]
  backup_retention      = 7
}

module "bastion" {
  source = "../../modules/bastion"
  ami                  = var.bastion_ami
  instance_type        = var.bastion_instance_type
  key_name             = var.bastion_key_name
  subnet_id            = values(var.public_subnets)[0].cidr
  security_group_ids   = [module.security_group.security_group_ids["bastion-host"]]
  name                 = "bastion-server"
}
