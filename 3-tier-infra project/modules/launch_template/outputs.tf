
output "launch_template_ids" {
  value = { for k, v in aws_launch_template.this : k => v.id }
}

output "launch_template_versions" {
  value = { for k, v in aws_launch_template.this : k => v.latest_version }
}
