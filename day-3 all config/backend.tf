terraform {
  backend "s3" {
    bucket = "bakka1122"    # create this in S3
    key    = "ec2/terraform.tfstate"
    region = "ap-south-1"
  }
}
