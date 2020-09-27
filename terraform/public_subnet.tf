resource "aws_internet_gateway" "test" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.default_tags,
    {
      "Name" = "test"
    },
  )
}

resource "aws_subnet" "public" {
  cidr_block        = var.public_cidr_block
  vpc_id            = aws_vpc.main.id
  availability_zone = var.availability_zone
  tags = merge(
    var.default_tags,
    {
      "Name" = "public_subnet"
    },
  )
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.default_tags,
    {
      "Name" = "public_route_table"
    },
  )
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  gateway_id             = aws_internet_gateway.test.id
  destination_cidr_block = var.all_ip
}

resource "aws_route_table_association" "public_route_association" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public.id
}

