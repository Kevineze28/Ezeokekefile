
# High-Availability Web Infrastructure with Terraform on AWS
This project demonstrates a highly available web application VPC infrastructure built on AWS using Terraform (Infrastructure as Code). Here's what it accomplishes:

# What It Does
Creates a resilient, production-ready web hosting environment that includes:

1. Multi-AZ deployment with two public subnets across different Availability Zones, ensuring the application stays online even if one zone fails.

2. Internet connectivity through an Internet Gateway, allowing users to access the web servers from anywhere.

3. Isolated routing with separate route tables for each subnet, providing better traffic control and security.

3. Web server hosting via EC2 instances running Apache in each subnet, distributing traffic across zones.

4. Security controls through configured security groups that manage what traffic can reach the servers.

# Key Benefits
The architecture ensures:

1. **High availability** - If one AZ goes down, the other continues serving traffic.

2. **Fault tolerance** - Redundant resources prevent single points of failure

3. **Scalability** - The foundation supports adding more resources as needed.

4. **Automation** - The entire infrastructure can be deployed, modified, or torn down with simple Terraform commands used such as Terraform init, Terraform fmt, Terraform validate, Terraform plan and Terraform apply and Terraform destroy.


# Detailed Documentation

## Architecture

The infrastructure includes the following components:

1. **VPC (Virtual Private Cloud)** - Isolated network environment.

2. **Public Subnets** - Deployed across different Availability Zones for redundancy.

3. **Internet Gateway (IGW)** - Enables internet connectivity for public subnets.

4. **Route Tables** - Separate routing tables (Public-01 , Public-02) for each subnet. 

5. **EC2 Instances** - Web servers running Apache in each subnet.

6. **Security Groups** - Configured to control inbound and outbound traffic.

7. **Apache** - Web Server Software

## Tech Stack  Used

1. **Terraform**  - Infrastructure as Code tool (IaC)
2. **Amazon Web Service (AWS)** - Cloud Provider
3. **Visual Studio Code** - Source-Code Editor 
4. **Local Terminal** 

## Project Structure

```
.
├── README.md
├── Provider.tf
├── VPC.tf
├── Subnet.tf
├── Internet_gateway.tf
├── Route_tables.tf
├── Security_groups.tf
├── EC2_instances.tf
├── Variables.tf
```


###  Terraform Commands Reference
After defining my provider and resource blocks for the required AWS services, I used Terraform commands in my local terminal to deploy the infrastructure. While Visual Studio Code was available as an alternative for running the commands, I preferred using the terminal directly for better control and efficiency. Below are the Terraform commands I used during the deployment process:

1. **Initialize Terraform**
   ```bash
   terraform init - Initializes the working directory containing the Terraform configuration files. 
   ```

2. **Validate the configuration**
   ```bash
   terraform validate - Validates the configuration files for syntax and internal consistency. 
   ```

2. **Format the code**
   ```bash
   terraform fmt - Formats the Terraform configuration files to a canonical style. 
   ```

3. **Preview the changes**
   ```bash
   terraform plan - Generates and shows an execution plan. This shows what actions will be taken without actually applying them. 
   ```

4. **Apply the configuration**
   ```bash
   terraform apply - Applies the changes required to reach the desired state as defined in the configuration files. 
   ```
   Type `yes` when prompted to confirm.

5. **Access your web servers**
   After deployment, Terraform will output the deployed code into the AWS console. 

6. **Apply the configuration**
   ```bash
   terraform destroy - Destroys the Terraform-managed infrastructure. Used to tear down all resources defined in the configuration. 

**Please note:** The terraform destroy command is used to remove infrastructure that was previously deployed using Terraform. It can be used to destroy all resources managed by Terraform in your AWS environment or selectively target specific resource blocks for removal.

##  Terraform Codes - Variables

#### The following Terraform configuration includes the provider block setup and resource block definitions, with arguments converted into variables to enhance code reusability and maintainability:

**Provider.tf**:
```hcl
provider "aws" {
  region = var.aws_region
}
```

**VPC.tf**:
```hcl
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "main-vpc"
  }
}
```
**Subnet.tf**:
```hcl
resource "aws_subnet" "public1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.ps1_cidr
  availability_zone = var.ps1_az
  tags = {
    Name = "public-subnet1"
  }
}


resource "aws_subnet" "public2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.ps2_cidr
  availability_zone = var.ps2_az
  tags = {
    Name = "public-subnet2"
  }
}
```
**Routetable.tf**:
```hcl

resource "aws_route_table" "Public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.route_table_igw
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_route_table_association" "Publicsubnet1" {
  subnet_id      = var.ps1_rt_tag
  route_table_id = var.ps1_rt_tag
}

resource "aws_route_table_association" "Publicsubnet2" {
  subnet_id      = var.ps2_rt_tag
  route_table_id = var.ps2_rt_tag
}  
```
**Securitygroup.tf**:
```hcl
resource "aws_security_group" "mysecuritygroupproject" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "mysecuritygroupproject"
  }
}


resource "aws_security_group_rule" "ingress_allow_all_ipv4" {
  type              = "ingress"
  from_port         = var.ingress_from_port
  to_port           = var.ingress_to_port
  protocol          = var.ingress_protocol
  cidr_blocks       = var.ingress_ipv4_cidr_blocks
  security_group_id = aws_security_group.mysecuritygroupproject.id
  description       = "Allow all inbound IPv4 (testing only)"
}


resource "aws_security_group_rule" "ingress_allow_all_ipv6" {
  type              = "ingress"
  from_port         = var.ingress_from_port
  to_port           = var.ingress_to_port
  protocol          = var.ingress_protocol
  ipv6_cidr_blocks  = var.ingress_ipv6_cidr_blocks
  security_group_id = aws_security_group.mysecuritygroupproject.id
  description       = "Allow all inbound IPv6 (testing only)"
}


resource "aws_security_group_rule" "egress_allow_all_ipv4" {
  type              = "egress"
  from_port         = var.egress_from_port
  to_port           = var.egress_to_port
  protocol          = var.egress_protocol
  cidr_blocks       = var.egress_ipv4_cidr_blocks
  security_group_id = aws_security_group.mysecuritygroupproject.id
  description       = "Allow all outbound IPv4"
}


resource "aws_security_group_rule" "egress_allow_all_ipv6" {
  type              = "egress"
  from_port         = var.egress_from_port
  to_port           = var.egress_to_port
  protocol          = var.egress_protocol
  ipv6_cidr_blocks  = var.egress_ipv6_cidr_blocks
  security_group_id = aws_security_group.mysecuritygroupproject.id
  description       = "Allow all outbound IPv6"
}
```

**Ec2instance.tf**:
```hcl
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
```

**internetgateway.tf**:
```hcl
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = var.internet_gateway
  }
}
```
**Variables.tf**: 

```hcl
variable "aws_region" {
  type        = string
  description = "aws region"
  default     = "us-west-1"
}

variable "vpc_cidr" {
  type        = string
  description = "vpc cidr block"
  default     = "10.0.0.0/24"
}

variable "ps1_az" {
  type        = string
  description = "public subnet 1 availability zone"
  default     = "us-west-1b"
}

variable "ps1_cidr" {
  type        = string
  description = "public 1 subnet cidr block"
  default     = "10.0.0.0/28"
}

variable "ps2_az" {
  type        = string
  description = "public subnet 2 availability zone"
  default     = "us-west-1c"
}

variable "ps2_cidr" {
  type        = string
  description = "public 2 subnet cidr block"
  default     = "10.0.0.128/25"
}

variable "route_table_igw" {
  type        = string
  description = "route table internet gateway"
  default     = "0.0.0.0/0"
}

variable "ps1_rt_tag" {
  type        = string
  description = "route table tag for  public assiociation subnet 1"
  default     = "public route table subnet 1"
}

variable "ps2_rt_tag" {
  type        = string
  description = "route table tag for  public assiociation subnet 2"
  default     = "public route table subnet 2"
}

variable "sg_name" {
  description = "Name of the security group"
  type        = string
  default     = "mysecuritygroupproject"
}

variable "sg_description" {
  description = "Description of the security group"
  type        = string
  default     = "Security group for my project"
}

variable "ingress_ipv4_cidr_blocks" {
  description = "CIDR blocks for IPv4 ingress traffic"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "ingress_ipv6_cidr_blocks" {
  description = "CIDR blocks for IPv6 ingress traffic"
  type        = list(string)
  default     = ["::/0"]
}

variable "ingress_from_port" {
  description = "Starting port for ingress traffic (0 for all)"
  type        = number
  default     = 0
}

variable "ingress_to_port" {
  description = "Ending port for ingress traffic (0 for all)"
  type        = number
  default     = 0
}

variable "ingress_protocol" {
  description = "Protocol for ingress traffic (-1 for all)"
  type        = string
  default     = "-1"
}

variable "egress_ipv4_cidr_blocks" {
  description = "CIDR blocks for IPv4 egress traffic"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "egress_ipv6_cidr_blocks" {
  description = "CIDR blocks for IPv6 egress traffic"
  type        = list(string)
  default     = ["::/0"]
}

variable "egress_from_port" {
  description = "Starting port for egress traffic (0 for all)"
  type        = number
  default     = 0
}

variable "egress_to_port" {
  description = "Ending port for egress traffic (0 for all)"
  type        = number
  default     = 0
}

variable "egress_protocol" {
  description = "Protocol for egress traffic (-1 for all)"
  type        = string
  default     = "-1"
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
  default     = "ami-00271c85bf8a52b84"
}

variable "instance_type" {
  description = "Instance type for EC2 instances"
  type        = string
  default     = "t2.micro"
}

variable "associate_public_ip" {
  description = "Whether to associate a public IP address"
  type        = bool
  default     = true
}

variable "instance1_name" {
  description = "Name tag for first EC2 instance"
  type        = string
  default     = "Apache-01"
}

variable "instance2_name" {
  description = "Name tag for second EC2 instance"
  type        = string
  default     = "Apache-02"
}

variable "instance1_html_content" {
  description = "HTML content for first instance"
  type        = string
  default     = "<h1>Apache Server - Subnet 01</h1>"
}

variable "instance2_html_content" {
  description = "HTML content for second instance"
  type        = string
  default     = "<h1>Apache Server - Subnet 02</h1>"
}

variable "internet_gateway" {
  description = "My Internet Gateway"
  type        = string
  default     = "main-igw"
}
```



## Link to the VPC Infastructure (Mind Map)

https://docs.google.com/document/d/e/2PACX-1vS1QC5xAWm4YkJsvTusseGvuUzPjfcIVw5EP5S4OwgGFafyw4qnv4qE6bUF-E5_pRGE6a2QDfqVu3m6/pub 


