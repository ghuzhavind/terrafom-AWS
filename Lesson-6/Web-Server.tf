#----------------------------------------------------------------
# My Terraform 
#
# Build Web Server during Bootstrap
#----------------------------------------------------------------

provider "aws" {
  region = "eu-central-1"
}

resource "aws_eip" "my_static_ip" {
  instance = aws_instance.my_web_server.id
}

resource "aws_instance" "my_web_server" {
  ami                    = "ami-09cb21a1e29bcebf0"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_web_server.id]
  user_data = templatefile("user-data.sh.tpl", {
    f_name = "Danil",
    l_name = "Guzhavin",
    names  = ["Vasya", "Kolya", "Sebastian", "John", "Mike"]
  })
  user_data_replace_on_change = true

  tags = {
    Name  = "WebServer Build by Terraform"
    Owner = "Danil Guzhavin"
  }

  lifecycle {
    create_before_destroy = true
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

