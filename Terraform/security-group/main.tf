# This is Secuirty-Group folder which creates Secuirty-Group for EC2-Instances
# These are the variables used in this folder
variable "vpc_id" {}
variable "sg_cidr" {}

# This is Secuirty-Group for my EC2-Instances
resource "aws_security_group" "project-ec2-sg" {
    vpc_id = var.vpc_id
    description = "This Security Group allows traffic from Particular IP-Address"
    
    tags = {
      Name = "project-ec2-sg"
    }
}

resource "aws_vpc_security_group_ingress_rule" "ingress-rule-ssh-sg" {
    security_group_id = aws_security_group.project-ec2-sg.id
    ip_protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_ipv4 = var.sg_cidr
}
resource "aws_vpc_security_group_egress_rule" "egress-rule-sg" {
  security_group_id = aws_security_group.project-ec2-sg.id
  ip_protocol = "-1"
  cidr_ipv4 = "0.0.0.0/0"
}

output "project-ec2-sg" {
  value = aws_security_group.project-ec2-sg.id
}

