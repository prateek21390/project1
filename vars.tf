
variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-08c40ec9ead489470"
  }
}
variable "AWS_REGION" {
  default = "us-east-1"
}
variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}