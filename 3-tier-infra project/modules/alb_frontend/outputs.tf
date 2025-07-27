output "alb_arn" {
  value = aws_lb.frontend.arn
}

output "target_group_arn" {
  value = aws_lb_target_group.frontend.arn
}