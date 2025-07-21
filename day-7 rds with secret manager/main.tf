data "aws_availability_zones" "available" {}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "custom-vpc"
  }
}

resource "aws_subnet" "rds_subnets" {
  count             = length(var.subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "rds-subnet-${count.index}"
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "custom-db-subnet-group"
  subnet_ids = aws_subnet.rds_subnets[*].id

  tags = {
    Name = "custom-db-subnet-group"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Allow internal DB access"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg"
  }
}

resource "aws_secretsmanager_secret" "rds_secret" {
  name                    = "rds-credentials"
  description             = "RDS admin credentials stored securely"
  recovery_window_in_days = 7

  tags = {
    Environment = "production"
  }
}

resource "aws_secretsmanager_secret_version" "rds_secret_version" {
  secret_id     = aws_secretsmanager_secret.rds_secret.id
  secret_string = jsonencode({
    username = var.db_username
    password = var.db_password
  })
}

resource "aws_db_instance" "rds" {
  identifier             = var.db_instance_identifier
  allocated_storage      = 20
  storage_type           = "gp3"
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  username               = var.db_username
  password               = var.db_password
  db_name                = var.db_name
  multi_az               = true
  storage_encrypted      = true
  skip_final_snapshot    = true
  publicly_accessible    = false

  tags = {
    Environment = "production"
  }
}
