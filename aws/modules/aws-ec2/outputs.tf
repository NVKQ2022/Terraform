output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.this[0].id
}

output "instance_arn" {
  description = "The ARN of the EC2 instance"
  value       = aws_instance.this[0].arn
}

output "instance_private_dns" {
  description = "The private DNS name of the instance"
  value       = aws_instance.this[0].private_dns
}

output "instance_private_ip" {
  description = "The private IP address of the instance"
  value       = aws_instance.this[0].private_ip
}

output "instance_public_dns" {
  description = "The public DNS name of the instance (if public IP is assigned)"
  value       = aws_instance.this[0].public_dns
}

output "instance_public_ip" {
  description = "The public IP address of the instance (if public IP is assigned)"
  value       = aws_instance.this[0].public_ip
}

output "instance_availability_zone" {
  description = "The availability zone of the instance"
  value       = aws_instance.this[0].availability_zone
}

output "instance_vpc_id" {
  description = "The VPC ID of the instance"
  value       = aws_instance.this[0].vpc_security_group_ids
}

output "ebs_volume_ids" {
  description = "Map of additional EBS volume IDs attached to the instance"
  value       = { for k, v in aws_ebs_volume.additional : k => v.id }
}
