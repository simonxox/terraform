output "launch_template_id" {
  value       = aws_launch_template.this.id
  description = "Launch Template ID"
}

output "launch_template_name" {
  value       = aws_launch_template.this.name
  description = "Launch Template Name"
}
