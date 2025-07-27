
vpc_name   = "three-tier-vpc"
vpc_cidr   = "172.20.0.0/16"

public_subnets = {
  pub1 = { cidr = "172.20.1.0/24", az = "us-east-1a", name = "pub-1a" }
  pub2 = { cidr = "172.20.2.0/24", az = "us-east-1b", name = "pub-2b" }
}

private_subnets = {
  prvt3 = { cidr = "172.20.3.0/24", az = "us-east-1a", name = "prvt-3a" }
  prvt4 = { cidr = "172.20.4.0/24", az = "us-east-1b", name = "prvt-4b" }
  prvt5 = { cidr = "172.20.5.0/24", az = "us-east-1a", name = "prvt-5a" }
  prvt6 = { cidr = "172.20.6.0/24", az = "us-east-1b", name = "prvt-6b" }
}

security_groups = {
  "bastion-host" = {
    name = "bastion-host"
    description = "Allow SSH"
    ingress = [{
      description = "SSH"
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }]
    egress = [{
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }]
  }

  "alb-frontend-sg" = {
    name = "alb-frontend"
    description = "Allow HTTP/HTTPS"
    ingress = [
      { description = "HTTP", from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
      { description = "HTTPS", from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
    ]
    egress = [{
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }]
  }

  "alb-backend-sg" = {
    name = "alb-backend"
    description = "Allow HTTP from ALB"
    ingress = [{
      description = "HTTP"
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }]
    egress = [{
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }]
  }

  "rds" = {
    name = "rds"
    description = "Allow MySQL from backend"
    ingress = [{
      description = "MySQL"
      from_port = 3306
      to_port = 3306
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }]
    egress = [{
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }]
  }
}

launch_templates = {
  "frontend" = {
    name               = "frontend-template"
    description        = "Frontend LT"
    ami_name           = "frontend-ami"
    ami_owner          = "self"
    instance_type      = "t2.micro"
    key_name           = "your-key"
    security_group_ids = ["sg-frontend"]
  }
  "backend" = {
    name               = "backend-template"
    description        = "Backend LT"
    ami_name           = "backend-ami"
    ami_owner          = "self"
    instance_type      = "t2.micro"
    key_name           = "your-key"
    security_group_ids = ["sg-backend"]
  }
}

autoscaling_groups = {
  "frontend-asg" = {
    desired_capacity       = 1
    max_size               = 1
    min_size               = 1
    subnet_ids             = ["subnet-1", "subnet-2"]
    target_group_arns      = ["tg-arn-frontend"]
    launch_template_id     = "lt-id-frontend"
    launch_template_version = "1"
    tag_name               = "frontend-asg"
  }
  "backend-asg" = {
    desired_capacity       = 1
    max_size               = 1
    min_size               = 1
    subnet_ids             = ["subnet-3", "subnet-4"]
    target_group_arns      = ["tg-arn-backend"]
    launch_template_id     = "lt-id-backend"
    launch_template_version = "1"
    tag_name               = "backend-asg"
  }
}

frontend_tg_name = "frontend-tg"
frontend_lb_name = "frontend-alb"
backend_tg_name  = "backend-tg"
backend_lb_name  = "backend-alb"

db_identifier     = "book-rds"
subnet_group_name = "db-subnet-group"
db_name           = "mydb"
db_username       = "admin"
db_password       = "password123"

bastion_ami            = "ami-xxxxxxxx"
bastion_instance_type  = "t2.micro"
bastion_key_name       = "your-key"
