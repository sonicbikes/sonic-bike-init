Sonic Bike Init
============================

Scripts used to startup the sonic bike system. There are three elements that need configering in order to get the system up and running:

- Operorating system gi

To Install everything from scratch
------------------------------------------------
Check if you are running kernel version "3.8.13-bone47". If you have an earler or later version then we can't be sure that things will work properly as we found errors with audio playback in later versions of the kernal. Use the following command to find out which version of the kernal you are running:

    $ uname -a
    
To install the correct version of the kernel, as root (not sudo). You may need to perform these actions while within an SD card as there needs to be space to download large files:

    $ wget https://github.com/RobertCNelson/linux-dev/archive/3.8.13-bone47.tar.gz
    $ gunzip 3.8.13-bone47.tar.gz
    $ tar -xvf 3.8.13-bone47.tar
    $ cd linux-dev-3.8.13-bone47
    $ sudo apt-get install bc lzma lzop libncurses5-dev 
    $ ./build_kernel.sh

Create a directory for the sd card to mount to
-----------------------------------------------------
    
    sudo mkdir /home/sonic/sdcard

This directory should contain a configeration file named config.json and folders containing audio files

Create a systemd service so conic bike auto starts
-----------------------------------------------------

    sudo ln -s /home/sonic/sonic-bike-init/sonic-bike.service /etc/systemd/system/sonic-bike.service

