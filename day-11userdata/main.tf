resource "aws_instance" "ec2" {
ami = "ami-0d03cb826412c6b0f"
instance_type = "t2.micro"
user_data = file(userdata.sh)
tags = {
  Name = "testuserdata"
}
  
}