output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.name.id
}

output "public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.name.public_ip
}

output "private_ip" {
  description = "Private IP of the EC2 instance"
  value       = aws_instance.name.private_ip
}
