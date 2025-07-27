
variable "db_identifier" {
  type = string
}

variable "subnet_group_name" {
  type = string
}

variable "db_subnet_ids" {
  type = list(string)
}

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "engine" {
  type    = string
  default = "mysql"
}

variable "engine_version" {
  type    = string
  default = "8.0.32"
}

variable "instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "multi_az" {
  type    = bool
  default = true
}

variable "db_name" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
  sensitive = true
}

variable "security_group_ids" {
  type = list(string)
}

variable "backup_retention" {
  type    = number
  default = 7
}
