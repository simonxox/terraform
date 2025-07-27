variable "lt_name_prefix" {
  type        = string
  description = "Prefix for launch template name"
}

variable "ami_id" {
  type        = string
}

variable "instance_type" {
  type        = string
}

variable "key_name" {
  type        = string
}

variable "security_group_ids" {
  type = list(string)
}
variable "user_data" {
  type        = string
  default     = ""
  description = "User data script to be passed to launch template"
}
