resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "terraform_ssh_key" {
  key_name   = "${var.region}-ssh-key"
  public_key = tls_private_key.ec2_key.public_key_openssh
}

resource "local_file" "private_key" {
  content = tls_private_key.ec2_key.private_key_pem
  #filename = "${var.region}-ssh-key.pem"
  filename = "${var.key_file_path}/${var.region}-ssh-key.pem"
}

