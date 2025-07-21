output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.this.id
}

output "private_ip" {
  description = "Private IP of the instance"
  value       = aws_instance.this.private_ip
}

output "public_ip" {
  description = "Public IP of the instance (if assigned)"
  value       = var.associate_public_ip ? aws_instance.this.public_ip : null
}

