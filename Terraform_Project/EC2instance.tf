resource "aws_instance" "Myec2instanceproject1" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.mysecuritygroupproject.id]
  subnet_id                   = aws_subnet.public1.id
  associate_public_ip_address = var.associate_public_ip

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "${var.instance1_html_content}" > /var/www/html/index.html
  EOF

  tags = {
    Name = var.instance1_name
  }
}

resource "aws_instance" "Myec2instanceproject2" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.mysecuritygroupproject.id]
  subnet_id                   = aws_subnet.public2.id
  associate_public_ip_address = var.associate_public_ip

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "${var.instance2_html_content}" > /var/www/html/index.html
  EOF

  tags = {
    Name = var.instance2_name
  }
} 