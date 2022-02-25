#! /bin/bash
if [ "$1" = "--build" ]; then packer build box-config.pkr.hcl; fi
if [ $? -ne 0 ]; then exit 1; fi
vagrant box remove centos/7 -f
vagrant box add centos/7 builds/packer_centos7_virtualbox.box
vagrant box remove centos/8 -f
vagrant box add centos/8 builds/packer_centos8_virtualbox.box
vagrant box remove centos/9 -f
vagrant box add centos/9 builds/packer_centos9_virtualbox.box
vagrant box remove ubuntu/focal -f
vagrant box add ubuntu/focal builds/packer_ubuntu-2004_virtualbox.box