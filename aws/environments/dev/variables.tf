variable "aws-region" {
  description = "AWS region for student account"
  type        = string
  default     = "us-east-1"
}

variable "vpc-cidr-block" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public-subnet-cidr-block" {
  description = "CIDR block for public subnet"
  type        = list(string)
  default     = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24",
    "10.0.4.0/24",
    "10.0.5.0/24",
    "10.0.6.0/24",
    "10.0.7.0/24",
    "10.0.8.0/24",
    "10.0.9.0/24",
    "10.0.10.0/24"
  ]
}
variable "private-subnet-cidr-block" {
  description = "CIDR block for private subnet"
  type        = list(string)
  default     = [
    "10.0.100.0/24",
    "10.0.101.0/24",
    "10.0.102.0/24",
    "10.0.103.0/24",
    "10.0.104.0/24",
    "10.0.105.0/24",
    "10.0.106.0/24",
    "10.0.107.0/24",
    "10.0.108.0/24",
    "10.0.109.0/24",
    "10.0.110.0/24"
  ]
}