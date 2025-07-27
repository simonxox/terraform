
output "alb_dns_name" {
  value = aws_lb.backend.dns_name
}

output "alb_arn" {
  value = aws_lb.backend.arn
}

output "tg_arn" {
  value = aws_lb_target_group.backend.arn
}
