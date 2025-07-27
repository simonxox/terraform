variable "tg_name" {
  type = string
}

variable "tg_port" {
  type = number
}

variable "tg_protocol" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "lb_name" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "subnet_ids" {
  type = list(string)
}

variable "listener_port" {
  type = number
}

variable "listener_protocol" {
  type = string
}
