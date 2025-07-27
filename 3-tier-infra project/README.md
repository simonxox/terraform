
# Modular AWS Terraform Project

This repository contains a complete, production-ready AWS infrastructure built using modularized Terraform.

## 📦 Modules Included
- VPC with public/private subnets
- RDS MySQL
- Security Groups
- Launch Templates
- Auto Scaling Groups
- Frontend & Backend ALBs
- Bastion Host

## 📁 Structure
```
terraform/
├── modules/
│   └── <each module>
├── environments/
│   └── dev/
│       ├── main.tf
│       ├── terraform.tfvars
```

## 🚀 Usage
```bash
cd environments/dev
terraform init
terraform plan
terraform apply
```

## 🛠 Prerequisites
- AWS CLI configured
- Terraform v1.3+

## 🙌 Author
Simon 
