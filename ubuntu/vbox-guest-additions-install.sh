apt-get install -y gcc make perl
mkdir -p /home/vagrant/VBoxGuestAdditions
mount /home/vagrant/VBoxGuestAdditions.iso /home/vagrant/VBoxGuestAdditions
sh /home/vagrant/VBoxGuestAdditions/VBoxLinuxAdditions.run
umount /home/vagrant/VBoxGuestAdditions
rm -r /home/vagrant/VBoxGuestAdditions
rm /home/vagrant/VBoxGuestAdditions.iso