resource "aws_autoscaling_group" "this" {
  for_each = var.autoscaling_groups

  name                      = each.key
  desired_capacity          = each.value.desired_capacity
  max_size                  = each.value.max_size
  min_size                  = each.value.min_size
  vpc_zone_identifier       = each.value.subnet_ids
  target_group_arns         = each.value.target_group_arns
  launch_template {
    id      = each.value.launch_template_id
    version = each.value.launch_template_version
  }
  tag {
    key                 = "Name"
    value               = each.value.tag_name
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
