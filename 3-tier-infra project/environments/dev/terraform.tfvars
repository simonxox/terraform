# ✅ VPC
vpc_name = "three-tier-vpc"
vpc_cidr = "172.20.0.0/16"

public_subnets = {
  pub1 = { cidr = "172.20.1.0/24", az = "ap-south-1a", name = "pub-1a" }
  pub2 = { cidr = "172.20.2.0/24", az = "ap-south-1b", name = "pub-2b" }
}

private_subnets = {
  prvt3 = { cidr = "172.20.3.0/24", az = "ap-south-1a", name = "prvt-3a" }
  prvt4 = { cidr = "172.20.4.0/24", az = "ap-south-1b", name = "prvt-4b" }
  prvt5 = { cidr = "172.20.5.0/24", az = "ap-south-1a", name = "prvt-5a" }
  prvt6 = { cidr = "172.20.6.0/24", az = "ap-south-1b", name = "prvt-6b" }
}

# ✅ Security Groups
security_groups = {
  "bastion-host" = {
    name        = "bastion-host"
    description = "Allow SSH"
    ingress = [{
      description = "SSH"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }]
    egress = [{
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }]
  }

  "alb-frontend-sg" = {
    name        = "alb-frontend"
    description = "Allow HTTP/HTTPS"
    ingress = [
      { description = "HTTP",  from_port = 80,  to_port = 80,  protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
      { description = "HTTPS", from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
    ]
    egress = [{
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }]
  }

  "alb-backend-sg" = {
    name        = "alb-backend"
    description = "Allow HTTP from ALB"
    ingress = [{
      description = "HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }]
    egress = [{
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }]
  }

  "rds" = {
    name        = "rds"
    description = "Allow MySQL from backend"
    ingress = [{
      description = "MySQL"
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }]
    egress = [{
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }]
  }
}

# ✅ Launch Templates
launch_templates = {
  "frontend" = {
    name               = "frontend"
    description        = "Frontend LT"
    ami_id             = "ami-08d7e81067277759e"
    instance_type      = "t2.micro"
    key_name           = "fun"
    security_group_ids = [] # filled dynamically
  }

  "backend" = {
    name               = "backend"
    description        = "Backend LT"
    ami_id             = "ami-0bbe8cbbeb9dffc7f"
    instance_type      = "t2.micro"
    key_name           = "fun"
    security_group_ids = [] # filled dynamically
  }
}

# ✅ Auto Scaling Groups
autoscaling_groups = {
  "frontend-asg" = {
    desired_capacity        = 1
    max_size                = 1
    min_size                = 1
    subnet_ids              = []
    target_group_arns       = []
    launch_template_id      = ""
    launch_template_version = "$Latest"
    tag_name                = "frontend-asg"
  }

  "backend-asg" = {
    desired_capacity        = 1
    max_size                = 1
    min_size                = 1
    subnet_ids              = []
    target_group_arns       = []
    launch_template_id      = ""
    launch_template_version = "$Latest"
    tag_name                = "backend-asg"
  }
}

# ✅ Load Balancer values
frontend_tg_name           = "frontend-tg"
frontend_lb_name           = "frontend-alb"
frontend_tg_port           = 80
frontend_tg_protocol       = "HTTP"
frontend_listener_port     = 80
frontend_listener_protocol = "HTTP"

backend_tg_name            = "backend-tg"
backend_lb_name            = "backend-alb"
backend_tg_port            = 80
backend_tg_protocol        = "HTTP"
backend_listener_port      = 80
backend_listener_protocol  = "HTTP"

# ✅ Bastion
bastion_ami           = "ami-0d03cb826412c6b0f"
bastion_instance_type = "t2.micro"
bastion_key_name      = "fun"

# ✅ RDS
db_identifier       = "book-rds"
subnet_group_name   = "db-subnet-group"
db_name             = "mydb"
db_username         = "admin"
db_password         = "password123"
db_instance_class   = "db.t3.micro"
db_engine           = "mysql"
db_engine_version   = "8.0.32"
