locals {
  main_availability_zone = data.aws_availability_zones.aviable
  main_vpc_id            = aws_vpc.main_vpc.id
}
