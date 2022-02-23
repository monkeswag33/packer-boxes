
source "virtualbox-iso" "ubuntu-2004" {
  boot_command            = ["<enter><enter><f6><esc><wait> ", "autoinstall ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/", "<enter>"]
  boot_wait               = "5s"
  guest_additions_path    = "VBoxGuestAdditions.iso"
  guest_os_type           = "Ubuntu_64"
  headless                = false
  http_directory          = "ubuntu"
  iso_checksum            = "sha256:F8E3086F3CEA0FB3FEFB29937AB5ED9D19E767079633960CCB50E76153EFFC98"
  iso_url                 = "ubuntu-20.04.3-live-server-amd64.iso"
  memory                  = 1024
  disk_size               = 65536 # 64 GB
  shutdown_command        = "echo 'vagrant'|sudo -S shutdown -P now"
  ssh_handshake_attempts  = "100"
  ssh_username            = "vagrant"
  ssh_password            = "vagrant"
  ssh_port                = 22
  ssh_wait_timeout        = "60m"
  vboxmanage              = [["modifyvm", "{{ .Name }}", "--memory", "1024"], ["modifyvm", "{{ .Name }}", "--cpus", "1"]]
  virtualbox_version_file = ".vbox_version"
  vm_name                 = "packer-ubuntu-20.04-amd64"
}

build {
  sources = ["source.virtualbox-iso.ubuntu-2004"]
  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    script          = "ubuntu/init.sh"
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
