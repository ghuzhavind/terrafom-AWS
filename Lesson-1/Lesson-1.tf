provider "aws" {}


resource "aws_instance" "My_Ubuntu" {
  count         = 2
  ami           = "ami-04e601abe3e1a910f"
  instance_type = "t2.micro"

  tags = {
    Name    = "My Ubuntu Server"
    Owner   = "Daniel"
    Project = "Terraform Lessons"
  }
}

resource "aws_instance" "My_Amazon" {
  ami           = "ami-09cb21a1e29bcebf0"
  instance_type = "t2.micro"

  tags = {
    Name    = "My Amazon Server"
    Owner   = "Daniel"
    Project = "Terraform Lessons"
  }
}
