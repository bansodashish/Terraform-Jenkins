#create AWS_VPC javahome_vpc

resource "aws_vpc" "javahome_vpc" {
  cidr_block = "${var.vpc_cidr}"

  tags = {
    Name = "javahome_vpc"
  }
}

# Build Inernet gateway and attach to javahome_vpc

resource "aws_internet_gateway" "javahome_igw" {
  vpc_id = "${aws_vpc.javahome_vpc.id}"

  tags = {
    Name = "javahome_igw"
  }
}

#Build Subnets for our VPC

resource "aws_subnet" "public" {
  count             = "${length(var.subnet_cidr)}"
  vpc_id            = "${aws_vpc.javahome_vpc.id}"
  availability_zone = "${element(var.azs,count.index)}"
  cidr_block        = "${element(var.subnet_cidr,count.index)}"
map_public_ip_on_launch = true

}

#Build Route table for Javahome_vpc

resource "aws_route_table" "public_rt" {
  vpc_id = "${aws_vpc.javahome_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.javahome_igw.id}"
  }


}

# Aws_route_table Association with Javahome_vpc

resource "aws_route_table_association" "a" {
  count          = "${length(var.subnet_cidr)}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public_rt.id}"
}
