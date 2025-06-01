# This are variables for Networking --> VPC, IGW, Subnets 
variable "vpc-cidr" {}
variable "subnet-cidr" {}

# This are variables for Security-Groups
variable "sg-cidr" {}

# This are variables for EC2-Instances
variable "ec2-names" {
  type = list(string)
}
variable "key-name" {}
variable "ec2-instance-type" {}
variable "ami-id" {}