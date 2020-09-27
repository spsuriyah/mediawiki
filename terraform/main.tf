provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  tags = merge(
    var.default_tags,
    {
      "Name" = var.vpc_name
    },
  )
}

