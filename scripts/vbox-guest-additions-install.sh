#! /bin/bash
whoami
sudo yum install bzip2 tar kernel-headers kernel-devel gcc make perl -y
sudo mkdir /home/vagrant/VBoxGuestAdditions
sudo mount /home/vagrant/VBoxGuestAdditions*.iso /home/vagrant/VBoxGuestAdditions
sudo sh /home/vagrant/VBoxGuestAdditions/VBoxLinuxAdditions.run
sudo umount /home/vagrant/VBoxGuestAdditions
sudo rm -r /home/vagrant/VBoxGuestAdditions