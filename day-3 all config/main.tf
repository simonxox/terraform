resource "aws_instance" "name" {
    ami = var.ami_id
    instance_type = var.instance_id
tags = {
  Name = "automation"
}

  
}