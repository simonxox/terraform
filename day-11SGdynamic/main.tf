
data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow specific ports with CIDR blocks"
  vpc_id      = data.aws_vpc.default.id

  dynamic "ingress" {
    for_each = var.port_cidr_map
    content {
      from_port   = ingress.key
      to_port     = ingress.key
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
  }
}