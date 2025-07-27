resource "aws_instance" "bastion" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  associate_public_ip_address = true  # ✅ IMPORTANT
  key_name               = var.key_name
  security_groups        = var.security_group_ids

  tags = {
    Name = var.name
  }
}
