resource "aws_ebs_volume" "appserver" {
  count = var.ec2_instance_count
  availability_zone = element(var.availability_zones, count.index)
  size              = var.volume_size
  type              = "gp2"
  encrypted         = "true"

  tags = merge(
    local.common_tags,
    local.backup_tags,
    {
      "Name"  = element(var.ec2_instance_names, count.index)
    },
  )
}

resource "aws_volume_attachment" "attach_appserver" {
  count       = var.ec2_instance_count
  device_name = "/dev/sdc"
  volume_id   = element(aws_ebs_volume.appserver.*.id, count.index)
  instance_id = element(aws_instance.appserver.*.id, count.index)
}
