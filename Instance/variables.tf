

variable "key_name" {
  description = "Desired name of AWS key pair"
  default     = "test.pem"
}

variable "access_key" {
  description = "Access Key to access the AWS Account"
}

variable "secret_key" {
  description = "  Secret Key to the AWS Account"
}

variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "ap-south-1"
}

variable "aws_ami" {
    default = "ami-0620d12a9cf777c87"
}

variable "vpc_cidr" {
  default = "10.10.0.0/16"
}

variable "public_subnets_cidr" {
  type    = list(string)
 default = "10.10.1.0/24"
}

variable "azs" {
  type    = list(string)
  default = "ap-south-1a"
}
