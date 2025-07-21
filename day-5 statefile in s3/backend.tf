terraform {
  backend "s3" {
    bucket = "simonjack"
    key    = "terraform.statefile"
    region = "ap-south-1"
  }
}
