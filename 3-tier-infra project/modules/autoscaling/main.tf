
resource "aws_autoscaling_group" "this" {
  for_each = var.autoscaling_groups

  name_prefix          = each.key
  desired_capacity     = each.value.desired_capacity
  max_size             = each.value.max_size
  min_size             = each.value.min_size
  vpc_zone_identifier  = each.value.subnet_ids
  target_group_arns    = each.value.target_group_arns
  health_check_type    = "EC2"

  launch_template {
    id      = each.value.launch_template_id
    version = each.value.launch_template_version
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["desired_capacity"]
  }

  tag {
    key                 = "Name"
    value               = each.value.tag_name
    propagate_at_launch = true
  }
}
