# VPC
variable "vpc_name" {
  type        = string
  description = "Name of the VPC"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnets" {
  type = map(object({
    cidr = string
    az   = string
    name = string
  }))
  description = "Map of public subnet details"
}

variable "private_subnets" {
  type = map(object({
    cidr = string
    az   = string
    name = string
  }))
  description = "Map of private subnet details"
}

# Security Groups
variable "security_groups" {
  description = "Security group definitions"
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

# Launch Templates
variable "launch_templates" {
  type = map(object({
    name               = string
    description        = string
    ami_id             = string
    instance_type      = string
    key_name           = string
    security_group_ids = list(string)
  }))
  description = "Launch template definitions"
}

# Auto Scaling Groups
variable "autoscaling_groups" {
  type = map(object({
    desired_capacity        = number
    max_size                = number
    min_size                = number
    subnet_ids              = list(string)
    target_group_arns       = list(string)
    launch_template_id      = string
    launch_template_version = string
    tag_name                = string
  }))
  description = "Auto scaling group definitions"
}

# ALB - Frontend
variable "frontend_tg_name" {
  type        = string
  description = "Target group name for frontend"
}

variable "frontend_lb_name" {
  type        = string
  description = "Load balancer name for frontend"
}

variable "frontend_tg_port" {
  type        = number
  description = "Target group port for frontend"
}

variable "frontend_tg_protocol" {
  type        = string
  description = "Target group protocol for frontend"
}

variable "frontend_listener_port" {
  type        = number
  description = "Listener port for frontend"
}

variable "frontend_listener_protocol" {
  type        = string
  description = "Listener protocol for frontend"
}

# ALB - Backend
variable "backend_tg_name" {
  type        = string
  description = "Target group name for backend"
}

variable "backend_lb_name" {
  type        = string
  description = "Load balancer name for backend"
}

variable "backend_tg_port" {
  type        = number
  description = "Target group port for backend"
}

variable "backend_tg_protocol" {
  type        = string
  description = "Target group protocol for backend"
}

variable "backend_listener_port" {
  type        = number
  description = "Listener port for backend"
}

variable "backend_listener_protocol" {
  type        = string
  description = "Listener protocol for backend"
}

# RDS
variable "db_identifier" {
  type        = string
  description = "RDS DB identifier"
}

variable "subnet_group_name" {
  type        = string
  description = "Name of the RDS subnet group"
}

variable "db_name" {
  type        = string
  description = "Database name"
}

variable "db_username" {
  type        = string
  description = "Master username"
}

variable "db_password" {
  type        = string
  description = "Master password"
}

variable "db_instance_class" {
  type        = string
  description = "RDS DB instance class"
}

variable "db_engine" {
  type        = string
  description = "RDS DB engine (e.g., mysql)"
}

variable "db_engine_version" {
  type        = string
  description = "RDS DB engine version"
}

# Bastion
variable "bastion_ami" {
  type        = string
  description = "AMI ID for Bastion instance"
}

variable "bastion_instance_type" {
  type        = string
  description = "Instance type for Bastion"
}

variable "bastion_key_name" {
  type        = string
  description = "Key pair name for SSH into Bastion"
}
