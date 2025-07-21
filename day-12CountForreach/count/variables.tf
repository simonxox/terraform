variable "ami" {
  type = string
}
variable "instance_type" {
    type = string 

}

variable "env" {
  type    = list(string)
  default = [ "dev", "test", "prod"]
}