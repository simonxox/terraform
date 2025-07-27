
variable "launch_templates" {
  type = map(object({
    name               = string
    description        = string
    ami_name           = string
    ami_owner          = string
    instance_type      = string
    key_name           = string
    security_group_ids = list(string)
  }))
}
