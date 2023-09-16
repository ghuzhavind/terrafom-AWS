#----------------------------------------------------------------
# My Terraform 
#
#----------------------------------------------------------------

provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "my_web_server" {
  ami                    = "ami-09cb21a1e29bcebf0"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_web_server_sg.id]

  tags = {
    Name = "W-Server"
  }
  depends_on = [aws_instance.my_web_server_db, aws_instance.my_web_server_app]
}

resource "aws_instance" "my_web_server_app" {
  ami                    = "ami-09cb21a1e29bcebf0"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_web_server_sg.id]

  tags = {
    Name = "W-Server-APP"
  }
  depends_on = [aws_instance.my_web_server_db]
}

resource "aws_instance" "my_web_server_db" {
  ami                    = "ami-09cb21a1e29bcebf0"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_web_server_sg.id]

  tags = {
    Name = "W-Server-DB"
  }
}

resource "aws_security_group" "my_web_server_sg" {
  name = "My Security Group"

  dynamic "ingress" {
    for_each = ["80", "443", "22"]
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
    Name = "My Security Group"
  }
}

