#---------- MAIN VPCi ----------------------

resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.vpc_name}"
  }
}

#---------- MAIN IGW ----------------------

resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "${var.vpc_name}-IGW"
  }
}

#---------- PUBLIC SUBNET -----------------

resource "aws_subnet" "public_subnets" {
  count      = length(var.public_subnet_cidrs)
  vpc_id     = local.main_vpc_id
  cidr_block = element(var.public_subnet_cidrs, count.index)
  #availability_zone       = local.main_availability_zone.names[var.az_index]
  availability_zone       = local.main_availability_zone.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.vpc_name}-public-${count.index + 1}"
  }
}

#---------- PUBLIC ROUTE TABLE -------------------

resource "aws_route_table" "public_route" {
  vpc_id = local.main_vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }
  tags = {
    Name = "${var.vpc_name}-public-route"
  }
}

#---------- PUBLIC ROUTE TABLE ASSOCIATION -------

resource "aws_route_table_association" "public_routes" {
  count          = length(aws_subnet.public_subnets[*].id)
  route_table_id = aws_route_table.public_route.id
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
}


#---------- PRIVATE SUBNET ----------------


resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = local.main_vpc_id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = local.main_availability_zone.names[var.az_index]
  tags = {
    Name = "${var.vpc_name}-private-${count.index + 1}"
  }
}


#---------- NAT GATEWAY ------- -------------------

resource "aws_eip" "nat" {
  #count  = length(var.private_subnet_cidrs)
  count  = length(var.private_subnet_cidrs) > 0 ? 1 : 0
  domain = "vpc"
  tags = {
    Name = "${var.vpc_name}-eip"
  }
}

resource "aws_nat_gateway" "nat" {
  count         = length(var.private_subnet_cidrs) > 0 ? 1 : 0
  allocation_id = aws_eip.nat[0].id
  subnet_id     = aws_subnet.public_subnets[0].id
  tags = {
    Name = "${var.vpc_name}-nat-gw"
  }
}

#---------- PRIVATE ROUTE TABLE -------------------

resource "aws_route_table" "private_route" {
  count  = length(var.private_subnet_cidrs)
  vpc_id = local.main_vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat[0].id
  }
  tags = {
    Name = "${var.vpc_name}-private-route"
  }
}


#---------- PRIVATE ROUTE TABLE ASSOCIATION -------

resource "aws_route_table_association" "private_routes" {
  count          = length(aws_subnet.private_subnets[*].id)
  route_table_id = aws_route_table.private_route[count.index].id
  subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)
}
