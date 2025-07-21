#resource "aws_instance" "name" {
 # ami           = var.ami
  #instance_type = var.instance_type
  #count         = 3

  #tags = {
   # Name        = "dev-${count.index}"
    #Environment = "dev"
  #}
#}

resource "aws_instance" "name2" {
    ami = var.ami
    instance_type = var.instance_type
    count=length(var.env)

    tags = {
      Name = var.env[count.index]
    }
}

