#! /bin/bash
yum install bzip2 tar kernel-headers kernel-devel gcc make perl elfutils-libelf-devel -y
mkdir -p /home/vagrant/VBoxGuestAdditions
mount /home/vagrant/VBoxGuestAdditions.iso /home/vagrant/VBoxGuestAdditions
sh /home/vagrant/VBoxGuestAdditions/VBoxLinuxAdditions.run
umount /home/vagrant/VBoxGuestAdditions
rm -r /home/vagrant/VBoxGuestAdditions
rm /home/vagrant/VBoxGuestAdditions.iso