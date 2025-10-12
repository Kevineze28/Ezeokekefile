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