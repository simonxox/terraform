output "instance_id" {
  value = aws_instance.web.id
}
output "subnet_id" {
  value = var.subnet_id
}