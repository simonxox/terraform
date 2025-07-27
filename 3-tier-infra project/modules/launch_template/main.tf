
data "aws_ami" "ami_lookup" {
  for_each    = var.launch_templates
  most_recent = true
  owners      = [each.value.ami_owner]

  filter {
    name   = "name"
    values = [each.value.ami_name]
  }
}

resource "aws_launch_template" "this" {
  for_each = var.launch_templates

  name                   = each.value.name
  description            = each.value.description
  image_id               = data.aws_ami.ami_lookup[each.key].id
  instance_type          = each.value.instance_type
  vpc_security_group_ids = each.value.security_group_ids
  key_name               = each.value.key_name
  update_default_version = true

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = each.value.name
    }
  }
}
