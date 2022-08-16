provider "aws" {
}

terraform {
  backend "s3" {
    bucket = "terraform-coe-1232"
    key    = "remote.tfstate"
    region = "ap-south-1"
  }
}

module "appserver" {
  source              = "../../../modules/ec2"
  app_code            = "dev"
  env                 = "sandbox"
  domain_env          = "AWS_account"
  ami                 = "amzn2-ami-hvm*"
  ec2_instance_names  = ["awsec2test1"]
  ec2_instance_count  = "1"
  vpc_name            = "vpc-39727a51"
  subnet_ids          = ["subnet-00556468"]
  availability_zones  = ["ap-south-1a"]
  private_ips         = ["172.31.47.122"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  egress_cidr_blocks  = ["0.0.0.0/0"]
  instance_type       = "t2.micro"
  volume_size         = "50"
}
