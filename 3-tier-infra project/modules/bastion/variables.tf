variable "ami" {
  description = "AMI ID for Bastion host"
  type        = string
}

variable "instance_type" {
  description = "Bastion EC2 instance type"
  type        = string
}

variable "subnet_id" {
  description = "Public Subnet ID for Bastion host"
  type        = string
}

variable "security_group_ids" {
  description = "List of Security Group IDs for Bastion"
  type        = list(string)
}

variable "key_name" {
  description = "Key pair name"
  type        = string
}

variable "name" {
  description = "Tag Name"
  type        = string
}
