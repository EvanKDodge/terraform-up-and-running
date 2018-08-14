variable "server_port" {
    description = "http server port"
    default = 8080
}

output "public_ip" {
  value = "${aws_instance.example.public_ip}"
}


provider "aws" {
    region = "us-west-1"
}

resource "aws_instance" "example" {
    ami = "ami-4aa04129"
    instance_type = "t2.micro"
    vpc_security_group_ids = ["${aws_security_group.instance.id}"]

    user_data = <<-EOF
                #!/bin/bash
                echo "Hello, World!" > index.html
                nohup busybox httpd -f -p "${var.server_port}" &
                EOF

    tags {
        Name = "testweb"
    }
}

resource "aws_security_group" "instance" {
    name = "terraform_example_instance"

    ingress {
        from_port = "${var.server_port}"
        to_port = "${var.server_port}"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}