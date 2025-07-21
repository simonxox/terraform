output "rds_endpoint" {
  value       = aws_db_instance.rds.endpoint
  description = "RDS database connection endpoint"
}

output "rds_secret_arn" {
  value       = aws_secretsmanager_secret.rds_secret.arn
  description = "Secrets Manager ARN for RDS credentials"
}
