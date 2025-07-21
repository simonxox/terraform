module "test" {
  source = "github.com/simonxox/my-ec2-module.git?ref=main"

  name           = "dev"
  instance_type  = "t2.micro"
  ami            = "ami-0d03cb826412c6b0f"
  subnet_id      = "subnet-0c6f3359d78d8b511"

  instance_tags = {
    Name = "dev"
  }
}
