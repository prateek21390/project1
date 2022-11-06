resource "aws_route_table" "publicroute_table" {
vpc_id = aws_vpc.projectvpc.id

route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
}

}

resource "aws_route_table" "privateroute_table" {
vpc_id = aws_vpc.projectvpc.id
}