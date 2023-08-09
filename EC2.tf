resource "aws_instance" "MyEc2" {
    ami = data.aws_ami.myami.id
    instance_type = "t2.micro"
    subnet_id = aws_subnet.subnet1.id
    associate_public_ip_address = "true"
    key_name = "AWS_singapore"
    provisioner "remote-exec" {
    inline = [
         "sudo yum update",
         "sudo amazon-linux-extras install -y nginx1",
         #"sudo yum install -y nginx",
         "sudo systemctl start nginx",
    ]
    }
    connection {
        type        = "ssh"
        user        = "ec2-user"
        private_key = file("AWS_singapore.pem")
        host        = aws_instance.MyEc2.public_ip
    }
    provisioner "local-exec" {
        command = "echo $aws_instance.MyEc2.public_ip >>inventory.txt"
    }
}
