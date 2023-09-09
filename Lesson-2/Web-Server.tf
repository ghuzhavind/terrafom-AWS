#----------------------------------------------------------------
# My Terraform 
#
# Build Web Server during Bootstrap
#----------------------------------------------------------------

provider "aws" {
  region = "eu-central-1"

}

resource "aws_instance" "my_web_server" {
  ami                    = "ami-09cb21a1e29bcebf0"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.my_web_server.id]
  user_data              = <<EOF
#!/bin/bash
yum -y update
yum -y install httpd
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<h2>WebServer with IP: $myip</h2><br>Build by Terraform!"  >  /var/www/html/index.html
sudo service httpd start
chkconfig httpd on
EOF

  tags = {
    Name  = "WebServer Build by Terraform"
    Owner = "Danil Guzhavin"
  }
}

resource "aws_security_group" "my_web_server" {
  name        = "WebServer Security Group"
  description = "Allow TLS inbound traffic"

  dynamic "ingress" {
    for_each = ["80", "443"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "WebServer Security Group"
    Owner = "Danil Guzhavin"
  }
}
