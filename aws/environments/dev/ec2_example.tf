module "ec2" {
  source = "../../modules/aws-ec2"

  ami_id         = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI (update for your region)
  instance_type  = "t3.micro"
  subnet_id      = module.vpc.public_subnet_ids[0]
  key_name       = "my-key-pair"

  vpc_security_group_ids = [module.security_group.this_security_group_id]

  root_block_device = [{
    volume_type            = "gp3"
    volume_size            = 20
    encrypted              = true
    kms_key_id             = ""
    delete_on_termination  = true
  }]

  ebs_block_device = [{
    device_name           = "/dev/sdf"
    volume_type           = "gp3"
    volume_size           = 50
    encrypted             = true
    kms_key_id            = ""
    delete_on_termination = true
    throughput            = 125
    iops                  = 3000
  }]

  tags = {
    Environment = "dev"
    Project     = "example"
    ManagedBy   = "terraform"
  }

  name_prefix = "dev-app"
}
