region                  = "ap-south-1"
vpc_cidr                = "10.0.0.0/16"
subnet_cidrs            = ["10.0.1.0/24", "10.0.2.0/24"]

db_username             = "admin"
db_password             = "MySecurePassword123!"

db_instance_identifier  = "my-custom-db"
db_engine               = "mysql"
db_engine_version       = "8.0"
db_instance_class       = "db.t3.micro"
db_name                 = "mydatabase"
