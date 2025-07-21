variable "region" {
  type        = string
  description = "AWS region to deploy resources"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "subnet_cidrs" {
  type        = list(string)
  description = "List of subnet CIDRs for RDS"
}

variable "db_username" {
  type        = string
  description = "RDS admin username"
}

variable "db_password" {
  type        = string
  sensitive   = true
  description = "RDS admin password"
}

variable "db_instance_identifier" {
  type        = string
  description = "Unique identifier for the RDS instance"
}

variable "db_engine" {
  type        = string
  description = "Database engine (e.g., mysql)"
}

variable "db_engine_version" {
  type        = string
  description = "Version of the database engine"
}

variable "db_instance_class" {
  type        = string
  description = "RDS instance class"
}

variable "db_name" {
  type        = string
  description = "Initial database name"
}
