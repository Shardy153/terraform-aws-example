variable "region_name" {
  description = "Name of the region name in which all the resources will be created."
  type        = "string"
  default     = "us-west-1"
}

variable "availability_zone" {
  description = "Availability zone in which all the resources will be created."
  type        = "string"
  default     = "us-west-1b"
}

variable "cidr_block" {
  description = "CIDR block of VPC created"
  type        = "string"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block of Public Subnet"
  type        = "string"
  default     = "10.0.0.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block of Private Subnet"
  type        = "string"
  default     = "10.0.1.0/24"
}

variable "ami_id" {
  description = "ID of the AMI to be used"
  type        = "string"
  default     = "ami-969ab1f6"
}

variable "instance_type" {
  description = "Type of the instance"
  type        = "string"
  default     = "t2.micro"
}
