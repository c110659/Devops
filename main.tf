provider "aws" {
  region     = "us-east-1"
  }

resource "aws_instance" "myec2" {
  ami             = "ami-05fa00d4c63e32376"
  instance_type   = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sshport.id]
  key_name = "mycred"
  tags = {
    "Name" = "Test-ServerFromnewbranch_newlyedited"
  }
}

resource "aws_security_group" "sshport" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic"
  //vpc_id      = aws_vpc.main.id

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    //ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    //ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

output "ip1" {
  value = aws_instance.myec2.private_ip
}
