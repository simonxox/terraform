variable "ami" {}
variable "instance_type" {}
variable "key_name" {}
variable "subnet_id" {}
variable "security_group_ids" {
  type = list(string)
}
variable "associate_public_ip" {
  type = bool
}
variable "root_volume_size" {
  type = number
}
variable "root_volume_type" {}
variable "name" {}
variable "environment" {}
variable "project" {}
variable "extra_tags" {
  type    = map(string)
  default = {}
}
