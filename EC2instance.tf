resource "aws_instance" "Terraform-CICD" {
  ami           = "ami-0e6a50b0059fd2cc3" 
  instance_type = "t2.micro" 

  tags = {
    Name = "Terraform-CICD"
}
}