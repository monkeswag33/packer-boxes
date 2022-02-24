if [ "$1" = "--build" ]; then packer build box-config.pkr.hcl; fi
vagrant box remove centos/7
vagrant box add centos/7 builds/packer_centos7_virtualbox.box
vagrant box remove centos/8
vagrant box add centos/8 builds/packer_centos8_virtualbox.box
vagrant box remove ubuntu/focal
vagrant box add ubuntu/focal builds/packer_ubuntu-2004_virtualbox.box