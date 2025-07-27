variable "asg_configs" {
  description = "Map of autoscaling configurations"
  type = map(object({
    max_size            = number
    min_size            = number
    desired_capacity    = number
    subnet_ids          = list(string)
    target_group_arns   = list(string)
    launch_template_id  = string
  }))
}
