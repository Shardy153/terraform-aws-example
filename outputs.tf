output "aws_vpc_id" {
  description = "The ID of the VPC"
  value       = "${aws_vpc.vpc.id}"
}

output "public_subnet_id" {
  description = "The ID of the Public Subnet"
  value       = "${aws_subnet.public_subnet.id}"
}

output "public_key_name" {
  description = "Name of the Public key"
  value       = "${aws_key_pair.public_key.id}"
}

output "internet_gateway_id" {
  description = "The ID of internet gateway id"
  value       = "${aws_internet_gateway.internet_gateway.id}"
}

output "public_route_table_id" {
  description = "public route table id"
  value       = "${aws_route_table.public_route_table.id}"
}

output "public_route_id" {
  description = "public route id"
  value       = "${aws_route.public_route.id}"
}

output "public_route_table_association_id" {
  description = "public route table association id"
  value       = "${aws_route_table_association.public_route_table_association.id}"
}

output "private_subnet_id" {
  description = "The ID of the Private Subnet"
  value       = "${aws_subnet.private_subnet.id}"
}

output "private_key_name" {
  description = "Private key name"
  value       = "${aws_key_pair.private_key.id}"
}

output "private_route_table_id" {
  description = "private_route_table_id"
  value       = "${aws_route_table.private_route_table.id}"
}

output "private_route_id" {
  description = "private_route_id"
  value       = "${aws_route.private_route.id}"
}

output "private_route_table_association_id" {
  description = "private_route_table_association_id"
  value       = "${aws_route_table_association.private_route_table_association.id}"
}

output "public_sg_id" {
  description = "ID of the security_group attached with bastion instance"
  value       = "${aws_security_group.public_sg.id}"
}

output "private_sg_id" {
  description = "ID of the security_group attached with private instance"
  value       = "${aws_security_group.private_sg.id}"
}

output "bastion_id" {
  description = "ID of the private instance created"
  value       = "${aws_instance.bastion.id}"
}
output "bastion_ip" {
  description = "IP of the bastion instance created"
  value       = "${aws_instance.bastion.private_ip}"
}
output "private_instance_id" {
  description = "IP of the private instance created"
  value       = "${aws_instance.private_instance.id}"
}
output "private_instance_ip" {
  description = "IP of the private instance created"
  value       = "${aws_instance.private_instance.private_ip}"
}
