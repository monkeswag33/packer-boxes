mkdir -p /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
ssh-keygen -t rsa -b 4096 -N "" -f /home/vagrant/.ssh/id_rsa
curl https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub >> /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh