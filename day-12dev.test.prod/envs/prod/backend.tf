
terraform {
  backend "s3" {
    bucket         = "bakka112211"
    key            = "prod/terraform.tfstate"
    region         = "ap-south-1"
    use_lockfile = true
    
  }
}