provider "aws" {
    region = "us-west-1"
}

resource "aws_instance" "example" {
    ami = "ami-e0ba5c83"
    instance_type = "t2.micro"

    tags {
        Name = "my-butt"
    }
}