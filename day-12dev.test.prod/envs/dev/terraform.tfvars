ami                 = "ami-0d03cb826412c6b0f"
instance_type       = "t2.micro"
key_name            = "fun"
subnet_id           = "subnet-0c6f3359d78d8b511"
security_group_ids  = ["sg-0e69148bbe20dadeb"]
associate_public_ip = true
root_volume_size    = 8
root_volume_type    = "gp2"
name                = "dev-ec2"
environment         = "dev"
project             = "TerraformProject"
extra_tags = {
  owner = "Simon"
  purpose = "dev-testing"
}
