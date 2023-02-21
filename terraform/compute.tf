resource "aws_instance" "docker_hosts" {
  count = length(keys(data.template_file.docker_compose.rendered.services))

  ami = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  
  security_groups = [aws_security_group.allow_ssh.id]

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo amazon-linux-extras install docker -y",
      "sudo service docker start",
      "sudo usermod -a -G docker ec2-user"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip
  }

  tags = {
    Name = "docker-host-${count.index}"
  }
}

data "template_file" "docker_compose" {
  template = file("${path.module}/docker-compose.yml")
}

resource "null_resource" "docker_deploy" {
  depends_on = [aws_instance.docker_hosts]

  provisioner "local-exec" {
    for_each = keys(data.template_file.docker_compose.rendered.services)

    command = "docker-compose -H ssh://ec2-user@${aws_instance.docker_hosts[\"${each.key}\"].public_ip} up -d ${data.template_file.docker_compose.rendered.services[each.key].container_name}"
    working_dir = "${path.module}"
  }
}