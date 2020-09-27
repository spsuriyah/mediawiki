resource "aws_instance" "web_server" {
  ami                         = "ami-0dd861ee19fd50a16"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public.id
  key_name                    = var.key_name
  associate_public_ip_address = true
  count                       = "1"
  vpc_security_group_ids      = [aws_security_group.web_server_group.id]
  tags = merge(
    var.default_tags,
    {
      "Name"            = "web_server"
    },
  )

  volume_tags = merge(
    var.default_tags,
    {
      "Name" = "web_server"
    },
  )

  ebs_block_device {
    device_name = "/dev/xvdb"
    volume_size = "20"
    volume_type = "gp2"
  }
}

resource "aws_security_group" "web_server_group" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.default_tags,
    {
      "Name" = "web_server_group"
    },
  )
}

resource "aws_security_group_rule" "web_server_ingress_ssh" {
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.web_server_group.id
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = [var.all_ip]
}

resource "aws_security_group_rule" "web_server_egress_http" {
  from_port         = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.web_server_group.id
  to_port           = 80
  type              = "egress"
  cidr_blocks       = [var.all_ip]
}

resource "aws_security_group_rule" "web_server_egress_https" {
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.web_server_group.id
  to_port           = 443
  type              = "egress"
  cidr_blocks       = [var.all_ip]
}

