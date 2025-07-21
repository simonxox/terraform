module "ec2" {
  source               = "../../modules/ec2"
  ami                  = var.ami
  instance_type        = var.instance_type
  key_name             = var.key_name              
  subnet_id            = var.subnet_id               
  security_group_ids   = var.security_group_ids        
  associate_public_ip  = var.associate_public_ip
  root_volume_size     = var.root_volume_size
  root_volume_type     = var.root_volume_type
  name                 = var.name
  environment          = var.environment
  project              = var.project
  extra_tags           = var.extra_tags
}
