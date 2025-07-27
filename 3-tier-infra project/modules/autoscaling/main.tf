resource "aws_autoscaling_group" "this" {
  for_each = var.asg_configs

  name                      = each.key
  max_size                  = each.value.max_size
  min_size                  = each.value.min_size
  desired_capacity          = each.value.desired_capacity
  vpc_zone_identifier       = each.value.subnet_ids
  target_group_arns         = each.value.target_group_arns
  health_check_type         = "EC2"
  health_check_grace_period = 300
  launch_template {
    id      = each.value.launch_template_id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = each.key
    propagate_at_launch = true
  }
}
