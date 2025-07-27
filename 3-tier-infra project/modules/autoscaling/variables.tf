
variable "autoscaling_groups" {
  type = map(object({
    desired_capacity       = number
    max_size               = number
    min_size               = number
    subnet_ids             = list(string)
    target_group_arns      = list(string)
    launch_template_id     = string
    launch_template_version = string
    tag_name               = string
  }))
}
