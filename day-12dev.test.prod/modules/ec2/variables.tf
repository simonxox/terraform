variable "ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
}

variable "key_name" {
  description = "Key pair name"
  type        = string
}

variable "subnet_id" {
  description = "Subnet to launch instance in"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
}

variable "associate_public_ip" {
  description = "Whether to associate a public IP"
  type        = bool
  default     = false
}

variable "root_volume_size" {
  description = "Root EBS volume size (in GB)"
  type        = number
  default     = 8
}

variable "root_volume_type" {
  description = "Root volume type (gp2, gp3, etc.)"
  type        = string
  default     = "gp2"
}

variable "name" {
  description = "Name tag for EC2"
  type        = string
}

variable "environment" {
  description = "Environment name (dev/test/prod)"
  type        = string
}

variable "project" {
  description = "Project name"
  type        = string
}

variable "extra_tags" {
  description = "Additional tags (map)"
  type        = map(string)
  default     = {}
}
