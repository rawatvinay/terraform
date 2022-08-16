locals {
  backup_tags = {
    "Tech.BackUp.Time.HourOfDay" = "22"
    "Tech.BackUp.Retention.Days" = "07"
    "Tech.BackUp.RollFlag" = "false"
  }

  common_tags = {
    "Tech.Env" = upper(var.env)
    "Tech.AppCode" = upper(var.app_code)
    "ManagedByAutomation" = "true"
  }
}

variable "app_code" {
  description = "Name of the Application"
}

variable "vpc_name" {
  description = "Name of the VPC in which to create the instance"
}

variable "subnet_ids" {
  description = "A list of VPC Subnet IDs to launch in"
  type        = list(string)
}


variable "private_ips" {
  description = "A list of private IP address to associate with the instance in a VPC. Should match the number of instances."
  type        = list(string)
}

variable "ami" {
  description = "ID of AMI to use for the instance"
  type        = string
}

variable "availability_zones" {
  description = "Name of the availability Zone in which to create the instance"
}

variable "ec2_instance_count" {
  description = "number of instances that needs to be created"  
}

variable "ec2_instance_names" {
  description = "name of instances that needs to be created"  
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
}

variable "volume_size" {
  description = "The EBS size"
  type        = string
}

variable "env" {
  description = "Environment Name"
}

variable "domain_env" {
  description = "Environment Name"
  
}

variable "ingress_cidr_blocks" {
  description = "A list of CIDR for inbound rules"
  type        = list(string)
}


variable "egress_cidr_blocks" {
  description = "A list of CIDR for outbound rules."
  type        = list(string)
}