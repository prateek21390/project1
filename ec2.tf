resource "aws_instance" "PublicInstance" {
ami = "ami-08c40ec9ead489470"
instance_type = "t2.micro"
subnet_id = aws_subnet.projectsubnet.id
vpc_security_group_ids = [aws_security_group.default.id]

}

resource "aws_instance" "PublicInstance2" {
ami = "ami-08c40ec9ead489470"
instance_type = "t2.micro"
subnet_id = aws_subnet.projectsubnet2.id
vpc_security_group_ids = [aws_security_group.default.id]
}


#launch configuration for EC2
# resource "aws_launch_configuration" "webapp" {
#     name          = "web_config"
#     image_id      = "${lookup(var.AMIS,var.AWS_REGION)}"
#     instance_type = "t2.micro"
#     key_name = "Project"
#     security_groups = ["${aws_security_group.default.id}"]
#     associate_public_ip_address = true

#     user_data = <<USER_DATA
# #!/bin/bash
# sudo apt-get update
# sudo apt-get install nginx
# sudo systemctl enable nginx
# sudo systemctl start nginx
#     USER_DATA
#     lifecycle {
#       create_before_destroy = true
#     }
# }
