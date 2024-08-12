terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

provider "local" {}


resource "local_file" "install_iis" {
  content = <<-EOF
  Install-WindowsFeature -name Web-Server -IncludeManagementTools
  EOF
  filename = "install_iis.ps1"
}

resource "null_resource" "run_install_iis" {
  provisioner "local-exec" {
    command = "powershell.exe -ExecutionPolicy Bypass -File install_iis.ps1"
  }
  triggers = {
    always_run = "${timestamp()}"
  }
}


resource "null_resource" "start_iis" {
  provisioner "local-exec" {
    command = "iisreset /start"
  }
  depends_on = [null_resource.run_install_iis]
}
