output "Webserver1_ip" {
  value = "${aws_instance.DevOps-WebServer1.public_ip}"
}
