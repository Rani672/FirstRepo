resource "aws_vpc" "MyVPC" {
  cidr_block = lookup(var.cidr, terraform.workspace)

}
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.MyVPC.id

  tags = {
    Name = "IGW"
  }
}
resource "aws_default_route_table" "MRT" {
  default_route_table_id = aws_vpc.MyVPC.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
  tags = {
    Name = "MRT"
  }
}
resource "aws_route_table_association" "MRT" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_default_route_table.MRT.id
}
variable "cidr" {
    type = map
    default = {
        default = "30.30.0.0/16"
        dev = "10.10.0.0/16"
        prod = "15.15.0.0/16"
        stage = "20.20.0.0/16" 
    }
  }
resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.MyVPC.id
  cidr_block = lookup(var.cidr1, terraform.workspace) 
}
variable "cidr1" {
    type = map
    default = {
        default = "30.30.1.0/24"
        dev = "10.10.1.0/24"
        prod = "15.15.1.0/24"
        stage = "20.20.1.0/24" 
    }
}
