resource "aws_instance" "this" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  associate_public_ip_address = var.associate_public_ip

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = var.root_volume_type
    delete_on_termination = true
  }

  tags = merge(
    {
      Name        = var.name
      Environment = var.environment
      Project     = var.project
    },
    var.extra_tags
  )
}
