
resource "aws_db_subnet_group" "subnet_group" {
  name       = var.subnet_group_name
  subnet_ids = var.db_subnet_ids
  tags = {
    Name = var.subnet_group_name
  }
}

resource "aws_db_instance" "rds" {
  allocated_storage        = var.allocated_storage
  identifier               = var.db_identifier
  db_subnet_group_name     = aws_db_subnet_group.subnet_group.name
  engine                   = var.engine
  engine_version           = var.engine_version
  instance_class           = var.instance_class
  multi_az                 = var.multi_az
  db_name                  = var.db_name
  username                 = var.db_username
  password                 = var.db_password
  skip_final_snapshot      = true
  vpc_security_group_ids   = var.security_group_ids
  publicly_accessible      = false
  backup_retention_period  = var.backup_retention

  tags = {
    DB_identifier = var.db_identifier
  }
}


