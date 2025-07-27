
variable "vpc_name" {
  type        = string
  description = "Name tag for the VPC"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnets" {
  type = map(object({
    cidr = string
    az   = string
    name = string
  }))
  description = "Public subnet configuration"
}

variable "private_subnets" {
  type = map(object({
    cidr = string
    az   = string
    name = string
  }))
  description = "Private subnet configuration"
}
