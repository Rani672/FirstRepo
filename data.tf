data "aws_ami" "myami" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["amzn2-ami-kernel-5.10**"]
  }
}
output "publicip" {
  value = aws_instance.MyEc2.public_ip
}
