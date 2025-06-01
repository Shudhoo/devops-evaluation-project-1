# This is a ec2-Instance folder which will create 3 EC2-Instances as my managed Kubernetes-Cluster
# This are the variables used to create these resources
variable "ec2_names" {
    type = list(string)
}
variable "ec2_instance_type" {}
variable "sg_id" {}
variable "subnet_id" {}
variable "key_name" {}
variable "ami_id" {}

# This is key-pair for instance
resource "aws_key_pair" "instance-key-pair" {
  key_name = "my-key"
  public_key = var.key_name
}

# This is EC2-Instance creation 
resource "aws_instance" "aws-instance" {
  count = length(var.ec2_names)
  instance_type = var.ec2_instance_type
  ami = var.ami_id
  key_name = aws_key_pair.instance-key-pair.key_name
  vpc_security_group_ids = [var.sg_id]
  subnet_id = var.subnet_id
  associate_public_ip_address = true

  user_data = count.index == 0 ? file("./script.sh") : null
  tags = {
    Name = var.ec2_names[count.index]
  }
}