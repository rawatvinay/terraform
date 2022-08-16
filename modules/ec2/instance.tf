resource "aws_instance" "appserver" {
  count                  = var.ec2_instance_count
  ami                    = data.aws_ami.amazon-linux-2.id
  instance_type          = var.instance_type
  private_ip             = element(var.private_ips, count.index)
  user_data              = element(data.template_file.user_data.*.rendered, count.index)
  subnet_id              = element(var.subnet_ids, count.index)
  vpc_security_group_ids = [aws_security_group.allow_http.id]

  tags = merge(
    local.common_tags,
    local.backup_tags,
    {
      "Name" = element(var.ec2_instance_names, count.index)
    },
  )

  volume_tags = merge(
    local.common_tags,
    local.backup_tags,
    {
      "Name" = element(var.ec2_instance_names, count.index)
    },
  )
}

data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name  = "name"
    values = ["${var.ami}"]
  }
}


data "template_file" "user_data" {
  count       = var.ec2_instance_count
  template    = file("${path.module}/templates/userdata.tpl")

  vars  = {
    host_name  = element(var.ec2_instance_names, count.index)
    app_code   = var.app_code
    domain_env = var.domain_env
  }
}
