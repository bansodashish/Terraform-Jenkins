resource "aws_instance" "webserver" {
  count          = "${length(var.subnet_cidr)}"
  ami = "${var.webserver_ami}"
  instance_type = "${var.instance_type}"
  security_groups = ["${aws_security_group.webserver.id}"]
  subnet_id = "${element(aws_subnet.public.*.id,count.index)}"
  user_data = "${file("install.httpd.sh")}"
tags{
    Name = "server-${count.index}"
}
}
