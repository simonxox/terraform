#!/bin/bash
yum update -y
yum install -y httpd

systemctl start httpd
systemctl enable httpd

# Create a basic HTML file
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
  <title>Hello from Terraform</title>
</head>
<body>
  <h1 style="color:green;">🚀 Deployed via Terraform & EC2 User Data</h1>
  <p>This page is served by Apache running on an EC2 instance.</p>
</body>
</html>
EOF
