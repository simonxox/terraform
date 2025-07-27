# VPC
variable "vpc_name" { type = string }
variable "vpc_cidr" { type = string }

variable "public_subnets" {
  type = map(object({
    cidr = string
    az   = string
    name = string
  }))
}

variable "private_subnets" {
  type = map(object({
    cidr = string
    az   = string
    name = string
  }))
}

# Security Groups
variable "security_groups" {
  type = map(object({
    name        = string
    description = string
    ingress = list(object({
      description = string
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
    egress = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
  }))
}

# Launch Templates (security_group_ids is resolved in main.tf, not here)
variable "launch_templates" {
  type = map(object({
    name          = string
    description   = string
    ami_id        = string
    instance_type = string
    key_name      = string
  }))
}

# Auto Scaling Groups
variable "autoscaling_groups" {
  type = map(object({
    desired_capacity        = number
    max_size                = number
    min_size                = number
    subnet_ids              = list(string)
    target_group_arns       = list(string)
    launch_template_version = string
    tag_name                = string
  }))
}

# ALBs
variable "frontend_tg_name" { type = string }
variable "frontend_lb_name" { type = string }
variable "backend_tg_name"  { type = string }
variable "backend_lb_name"  { type = string }

# RDS
variable "db_identifier"     { type = string }
variable "subnet_group_name" { type = string }
variable "db_name"           { type = string }
variable "db_username"       { type = string }
variable "db_password" {
  type      = string
  sensitive = true
}

# Bastion
variable "bastion_ami"           { type = string }
variable "bastion_instance_type" { type = string }
variable "bastion_key_name"      { type = string }
