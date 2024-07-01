module "bastion-made-easy" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.common_tags.Name}-${var.common_tags.Environment}"
  ami  = data.aws_ami.ami_id.id

  instance_type               = "t3.micro"
  monitoring                  = true
  associate_public_ip_address = true
  vpc_security_group_ids      = var.sg_ids
  subnet_id                   = var.subnet_id

  tags = merge(
    var.common_tags,
    {
    Name        = "${var.common_tags.Name}-${var.common_tags.Environment}",
    }
  )
}