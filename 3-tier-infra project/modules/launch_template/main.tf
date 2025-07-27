resource "aws_launch_template" "this" {
  name_prefix   = var.lt_name_prefix
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name


network_interfaces {
  associate_public_ip_address = false
  security_groups             = var.security_group_ids
}


  user_data = var.user_data != "" ? base64encode(var.user_data) : null

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.lt_name_prefix}-instance"
    }
  }

  tags = {
    Name = "${var.lt_name_prefix}-lt"
  }
}
