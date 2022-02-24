# packer-boxes
My custom packer boxes

# Building
To build the packages, make sure [Packer](https://packer.io) and [Virtualbox](https://virtualbox.org). [Vagrant](https://vagrantup.com) should also be installed if you want to run the images that are built. (If Vagrant is not installed, remove the `post-processor` sections from the .hcl files)  
First build the images using Packer. If you want 