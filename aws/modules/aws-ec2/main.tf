locals {
  common_tags = merge(
    var.tags,
    {
      Name        = "${var.name_prefix}-instance"
      Environment = var.tags["Environment"] != null ? var.tags["Environment"] : "dev"
    }
  )

  root_block_device_config = {
    for i, v in var.root_block_device :
    v.device_name != null ? v.device_name : "/dev/sda1" => v
  }
}

resource "aws_instance" "this" {
  count = 1

  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = length(var.vpc_security_group_ids) > 0 ? var.vpc_security_group_ids : null
  key_name                    = var.key_name != "" ? var.key_name : null
  user_data                   = var.user_data
  iam_instance_profile        = var.iam_instance_profile != "" ? var.iam_instance_profile : null
  disable_api_termination     = var.disable_api_termination
  ebs_optimized               = var.enable_ebs_optimization
  private_dns_name_options {
    enable_resource_name_dns_aaaa_record = var.private_dns_name_options.enable_resource_name_dns_aaaa_record
    enable_resource_name_dns_a_record    = var.private_dns_name_options.enable_resource_name_dns_a_record
    hostname_type                        = var.private_dns_name_options.hostname_type
  }

  root_block_device {
    volume_type            = var.root_block_device[0].volume_type
    volume_size            = var.root_block_device[0].volume_size
    encrypted              = var.root_block_device[0].encrypted
    kms_key_id            = var.root_block_device[0].kms_key_id != "" ? var.root_block_device[0].kms_key_id : null
    delete_on_termination  = var.root_block_device[0].delete_on_termination
  }

  dynamic "ebs_block_device" {
    for_each = var.ebs_block_device
    content {
      device_name = ebs_block_device.value.device_name
      volume_type = ebs_block_device.value.volume_type
      volume_size = ebs_block_device.value.volume_size
      encrypted   = ebs_block_device.value.encrypted
      kms_key_id  = ebs_block_device.value.kms_key_id != "" ? ebs_block_device.value.kms_key_id : null
      delete_on_termination = ebs_block_device.value.delete_on_termination
      throughput  = ebs_block_device.value.throughput > 0 ? ebs_block_device.value.throughput : null
      iops        = ebs_block_device.value.iops > 0 ? ebs_block_device.value.iops : null
    }
  }

  tags = merge(local.common_tags, var.instance_tags, {
    Name = "${var.name_prefix}-instance"
  })
}

resource "aws_ebs_volume" "additional" {
  for_each = { for i, v in var.ebs_block_device : v.device_name => v }

  availability_zone = aws_instance.this[0].availability_zone
  volume_type       = each.value.volume_type
  size              = each.value.volume_size
  encrypted         = each.value.encrypted
  kms_key_id        = each.value.kms_key_id != "" ? each.value.kms_key_id : null
  throughput        = each.value.throughput > 0 ? each.value.throughput : null
  iops              = each.value.iops > 0 ? each.value.iops : null

  tags = merge(local.common_tags, {
    Name = "${var.name_prefix}-ebs-${each.value.device_name}"
  })
}

resource "aws_volume_attachment" "this" {
  for_each = { for i, v in var.ebs_block_device : v.device_name => v }

  device_name = each.value.device_name
  volume_id   = aws_ebs_volume.additional[each.value.device_name].id
  instance_id = aws_instance.this[0].id
}
