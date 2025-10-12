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