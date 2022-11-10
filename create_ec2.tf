resource "aws_instance" "BlueInstance" {
  ami = "ami-09d3b3274b6c5d4aa"
  instance_type = "t2.micro"
  key_name = "jemin"
  vpc_security_group_ids = [aws_security_group.web_server.id]
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd.x86_64
    systemctl start httpd.service
    systemctl enable httpd.service
    sudo echo "<body bgcolor='#04187A'><h1 style='color:red'>Blue Instance</h1>" > /var/www/html/index.html
    EOF
  tags = {
    "Name" = "Blue Instance"
  }
}

resource "aws_instance" "GreenInstance" {
  ami = "ami-09d3b3274b6c5d4aa"
  instance_type = "t2.micro"
  key_name = "jemin"
  vpc_security_group_ids = [aws_security_group.web_server.id]
  user_data = <<EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd.x86_64
    systemctl start httpd.service
    systemctl enable httpd.service
    sudo echo "<body bgcolor='#167A04'><h1 style='color:red'>Green Instance</h1>" > /var/www/html/index.html
    EOF
  tags = {
    "Name" = "Green Instance"
  }
}

resource "aws_security_group" "web_server" {
  name        = "web server"
  description = "Allow web server traffic"
  

  ingress {
    description      = "Webserver"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["103.183.82.98/32"]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "web server"
  }
}
