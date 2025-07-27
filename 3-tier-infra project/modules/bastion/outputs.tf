output "bastion_id" {
  value       = aws_instance.bastion.id
  description = "Bastion instance ID"
}

output "bastion_public_ip" {
  value       = aws_instance.bastion.public_ip
  description = "Public IP of Bastion host"
}
