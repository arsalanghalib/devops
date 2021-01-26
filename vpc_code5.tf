 /*
 VPC
 INTERNET GW
 PUBLIC SUBNET
 PRIVATE SUBNET
 PUBLIC ROUTE TABLE
 PRIVATE ROUTE TABLE

 ROUTE (IGW)
 ROUTE TABLE ASSOCIATION (PUBLIC SUBNET)
 ROUTE TABLE ASSOCIATION (PRIVATE SUBNET)

 NAT GW
 EIP

 */

resource "aws_vpc" "my" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "arsalan-vpc"
  }
}

resource "aws_internet_gateway" "my" {
  vpc_id = aws_vpc.my.id
  tags = {
    Name = "arsalan-ig"
  }  
}

resource "aws_subnet" "public" {
    vpc_id     = aws_vpc.my.id
    cidr_block = "10.0.10.0/24"
    availability_zone = "eu-central-1a"
    tags = {
        Name = "arsalan_subnet_pb"
    }
}

resource "aws_subnet" "private" {
    vpc_id     = aws_vpc.my.id
    cidr_block = "10.0.20.0/24"
    availability_zone = "eu-central-1a"
    tags = {
        Name = "arsalan_subnet_private"
    }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.my.id

  route {
    cidr_block = "10.0.10.0/24"
    gateway_id = aws_internet_gateway.my.id
  }

  tags = {
    Name = "arsalan-rt-public"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.my.id

  route {
    cidr_block = "10.0.20.0/24"
  }

  tags = {
    Name = "arsalan-rt-private"
  }
}

resource "aws_route" "public_ig" {
    route_table_id = aws_route_table.public.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my.id
}

# resource "aws_route_table_association" "public" {
#     subnet_id = aws_subnet.public.id
#     route_table_id=aws_route_table.public.id
# }

# resource "aws_route_table_association" "private" {
#     subnet_id = aws_subnet.private.id
#     route_table_id=aws_route_table.private.id
# }