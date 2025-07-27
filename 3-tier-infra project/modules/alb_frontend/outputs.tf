
output "alb_dns_name" {
  value = aws_lb.frontend.dns_name
}

output "alb_arn" {
  value = aws_lb.frontend.arn
}

output "tg_arn" {
  value = aws_lb_target_group.frontend.arn
}
