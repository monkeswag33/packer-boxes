variable "headless" {
  type = bool
  default = true
}

variable "memory" {
  type = number
  default = 1024
}

variable "cores" {
  type = number
  default = 1
}

variable "disk" {
  type = number
  default = 32768 # 32 GB
}

source "virtualbox-iso" "centos7" {
  boot_command            = ["<tab> text ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks_centos7.cfg<enter><wait>"]
  boot_wait               = "5s" # Change this if machine takes longer to boot up
  # set memory to variable "memory"
  memory                  = var.memory
  disk_size               = var.disk
  guest_additions_path    = "VBoxGuestAdditions.iso" # Makes it easier for the provision script since the filename will always be the same
  guest_os_type           = "RedHat_64"
  headless                = var.headless
  http_directory          = "centos"
  iso_checksum            = "sha256:07b94e6b1a0b0260b94c83d6bb76b26bf7a310dc78d7a9c7432809fb9bc6194a"
  iso_urls                = ["CentOS-7-x86_64-Minimal-2009.iso", "http://mirrors.mit.edu/centos/7/isos/x86_64/CentOS-7-x86_64-Minimal-2009.iso"]
  shutdown_command        = "echo 'vagrant'|sudo -S /sbin/halt -h -p"
  ssh_password            = "vagrant"
  ssh_port                = 22
  ssh_username            = "vagrant"
  ssh_wait_timeout        = "1800s"
  vboxmanage              = [["modifyvm", "{{ .Name }}", "--memory", "${var.memory}"], ["modifyvm", "{{ .Name }}", "--cpus", "${var.cores}"]]
  virtualbox_version_file = ".vbox_version"
  vm_name                 = "packer_centos_7_x86_64"
}

source "virtualbox-iso" "centos8" {
  boot_command            = ["<tab> text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks_centos8.cfg<enter><wait>"]
  boot_wait               = "5s"
  memory                  = var.memory
  disk_size               = var.disk # 64 GB
  guest_additions_path    = "VBoxGuestAdditions.iso"
  guest_os_type           = "RedHat_64"
  headless                = var.headless
  http_directory          = "centos"
  iso_checksum            = "sha256:A7B1B41F63AD897E788BABF97A7861E5AF219934D3AC486A0DDCDD343CA974F3"
  iso_urls                = ["CentOS-Stream-8-x86_64-latest-boot.iso", "http://repos.hou.layerhost.com/centos/8-stream/isos/x86_64/CentOS-Stream-8-x86_64-latest-boot.iso"]
  shutdown_command        = "echo 'vagrant'|sudo -S /sbin/halt -h -p"
  ssh_password            = "vagrant"
  ssh_port                = 22
  ssh_username            = "vagrant"
  ssh_wait_timeout        = "1800s"
  vboxmanage              = [["modifyvm", "{{ .Name }}", "--memory", "${var.memory}"], ["modifyvm", "{{ .Name }}", "--cpus", "${var.cores}"]]
  virtualbox_version_file = ".vbox_version"
  vm_name                 = "packer_centos_8_x86_64"
}

source "virtualbox-iso" "ubuntu-2004" {
  boot_command            = ["<enter><enter><f6><esc><wait> ", "autoinstall ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/", "<enter>"]
  boot_wait               = "5s"
  guest_additions_path    = "VBoxGuestAdditions.iso"
  guest_os_type           = "Ubuntu_64"
  headless                = false # For some reason, headless needs to be false for Virtualbox Guest Additions to install without hanging
  http_directory          = "ubuntu"
  iso_checksum            = "sha256:F8E3086F3CEA0FB3FEFB29937AB5ED9D19E767079633960CCB50E76153EFFC98"
  iso_urls                = ["ubuntu-20.04.3-live-server-amd64.iso", "https://mirror.pit.teraswitch.com/ubuntu-releases/20.04.3/ubuntu-20.04.3-live-server-amd64.iso"]
  memory                  = var.memory
  disk_size               = var.disk # 64 GB
  shutdown_command        = "echo 'vagrant'|sudo -S shutdown -P now"
  ssh_handshake_attempts  = "1000"
  ssh_username            = "vagrant"
  ssh_password            = "vagrant"
  ssh_port                = 22
  ssh_wait_timeout        = "120m"
  vboxmanage              = [["modifyvm", "{{ .Name }}", "--memory", "${var.memory}"], ["modifyvm", "{{ .Name }}", "--cpus", "${var.cores}"]]
  virtualbox_version_file = ".vbox_version"
  vm_name                 = "packer-ubuntu-20.04-amd64"
}

build {
  sources = ["source.virtualbox-iso.ubuntu-2004"]
  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get upgrade -y",
      "sudo apt-get autoremove -y"
    ]
  }
  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    script          = "ubuntu/vbox-guest-additions-install.sh"
  }
  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    script          = "ubuntu/ssh-setup.sh"
  }
  post-processor "vagrant" {
    output = "builds/packer_{{.BuildName}}_{{.Provider}}.box"
  }
}

build {
  sources = ["source.virtualbox-iso.centos7", "source.virtualbox-iso.centos8"]
  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    script          = "centos/vbox-guest-additions-install.sh"
  }
  post-processor "vagrant" {
    output = "builds/packer_{{.BuildName}}_{{.Provider}}.box"
  }
}
