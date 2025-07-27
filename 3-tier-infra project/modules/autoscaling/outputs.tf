
output "asg_names" {
  value = [for asg in aws_autoscaling_group.this : asg.name]
}
