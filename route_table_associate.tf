
#Public Association
resource "aws_route_table_association" "public1_association" {
  subnet_id      = aws_subnet.projectsubnet.id
  route_table_id = aws_route_table.publicroute_table.id

}
resource "aws_route_table_association" "public2_association" {
  subnet_id      = aws_subnet.projectsubnet2.id
  route_table_id = aws_route_table.publicroute_table.id
}


#Private Association
resource "aws_route_table_association" "private1_association" {
  subnet_id      = aws_subnet.projectprivatesubnet.id
  route_table_id = aws_route_table.privateroute_table.id
}
resource "aws_route_table_association" "private2_association" {
  subnet_id      = aws_subnet.projectprivatesubnet2.id
  route_table_id = aws_route_table.privateroute_table.id
}


