
provider "aws" {
  region = "${var.aws_region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}


resource "aws_instance" "DevOps-WebServer1" {
  instance_type = "t2.micro"
  ami = "${var.aws_ami}"
  tags = {
    Name = "DevOps-WebServer1"
  }
  key_name = "${var.key_name}"
  vpc_security_group_ids = [aws_security_group.DevOps-EC2-SG.id]
  subnet_id = "${aws_subnet.public-subnet.0.id}"

}

