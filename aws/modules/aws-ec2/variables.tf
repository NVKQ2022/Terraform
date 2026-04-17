variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The instance type (e.g., t2.micro, t3.medium)"
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "The VPC subnet ID to launch the instance in"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "List of security group IDs to associate with the instance"
  type        = list(string)
  default     = []
}

variable "key_name" {
  description = "The key pair name to associate with the instance"
  type        = string
  default     = ""
}

variable "user_data" {
  description = "User data script to pass to the instance on launch"
  type        = string
  default     = null
}

variable "iam_instance_profile" {
  description = "The IAM instance profile name to associate with the instance"
  type        = string
  default     = ""
}

variable "enable_ebs_optimization" {
  description = "Whether to enable EBS optimization for the instance"
  type        = bool
  default     = false
}

variable "root_block_device" {
  description = "Configuration for the root block device"
  type = list(object({
    volume_type = string
    volume_size = number
    encrypted   = bool
    kms_key_id  = string
    delete_on_termination = bool
  }))
  default = [{
    volume_type = "gp3"
    volume_size = 20
    encrypted   = true
    kms_key_id  = ""
    delete_on_termination = true
  }]
}

variable "ebs_block_device" {
  description = "Additional EBS block devices to attach to the instance"
  type = list(object({
    device_name = string
    volume_type = string
    volume_size = number
    encrypted   = bool
    kms_key_id  = string
    delete_on_termination = bool
    throughput  = number
    iops        = number
  }))
  default = []
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "instance_tags" {
  description = "A map of tags to add specifically to the instance"
  type        = map(string)
  default     = {}
}

variable "name_prefix" {
  description = "Prefix to add to resource names"
  type        = string
  default     = "ec2"
}

variable "disable_api_termination" {
  description = "Whether to disable API termination protection"
  type        = bool
  default     = false
}

variable "private_dns_name_options" {
  description = "Options for the private DNS name"
  type = object({
    enable_resource_name_dns_aaaa_record = bool
    enable_resource_name_dns_a_record    = bool
    hostname_type                        = string
  })
  default = {
    enable_resource_name_dns_aaaa_record = false
    enable_resource_name_dns_a_record    = true
    hostname_type                        = "ip-name"
  }
}
