
data "aws_vpc" "default" {
  default = true
}
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow specific ports with CIDR blocks"
  vpc_id      = data.aws_vpc.default.id

  dynamic "ingress" {
    for_each = {
      22   = "203.0.113.10/32"  # SSH - only your IP
      80   = "0.0.0.0/0"        # HTTP - open to all
      443  = "0.0.0.0/0"        # HTTPS - open to all
      3000 = "10.0.0.0/16"      # App Port - internal only
    }
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
