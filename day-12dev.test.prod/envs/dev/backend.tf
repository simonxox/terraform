
terraform {
  backend "s3" {
    bucket         = "bakka112211"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    use_lockfile = true
    
  }
}