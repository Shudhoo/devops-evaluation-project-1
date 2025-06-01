module "networking" {
  source = "./networking"
  public_subnet_cidr = var.subnet-cidr
  vpc_cidr = var.vpc-cidr
}

module "secuirty-group" {
    source = "./security-group"
    vpc_id = module.networking.project-vpc-id
    sg_cidr = var.sg-cidr
}

module "ec2-Instances" {
  source = "./ec2-instances"
  subnet_id = module.networking.project-public-subnet-id
  sg_id = module.secuirty-group.project-ec2-sg
  ec2_instance_type = var.ec2-instance-type
  ami_id = var.ami-id
  ec2_names = var.ec2-names
  key_name = var.key-name
}