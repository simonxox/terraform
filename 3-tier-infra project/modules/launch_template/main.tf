resource "aws_launch_template" "this" {
  name_prefix   = var.name
  description   = var.description
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  network_interfaces {
    security_groups             = var.security_group_ids
    associate_public_ip_address = false
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = var.name
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}
