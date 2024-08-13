terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

provider "local" {}

# Create PowerShell script to install and start IIS
resource "local_file" "install_and_start_iis" {
  content = <<-EOF
    # Check if IIS is installed
    if (-not (Get-WindowsFeature -Name Web-Server).Installed) {
        # Install IIS and include management tools
        Install-WindowsFeature -Name Web-Server -IncludeManagementTools
        Write-Host 'IIS Installed Successfully!'
    } else {
        Write-Host 'IIS is already installed.'
    }

    # Start IIS service
    iisreset /start
    Write-Host 'IIS Server Started Successfully!'
  EOF
  filename = "install_and_start_iis.ps1"
}

# Run the PowerShell script to install and start IIS
resource "null_resource" "run_iis_script" {
  provisioner "local-exec" {
    command = "powershell -ExecutionPolicy Bypass -File ${local_file.install_and_start_iis.filename}"
  }
}

output "iis_status" {
  value = "Checked IIS installation status and started IIS if it was not already installed."
}
