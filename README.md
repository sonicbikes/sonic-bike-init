Sonic Bike Init
============================

Scripts used to startup the sonic bike system. There are four seperate elements that need to be installed/configured in order to get the system up and running on a Raspberry PI V2 Model B and/or a Beagleboard xM.

A. The Hardware. <br />
B. Operating system. <br />
C. The software.<br />
E. USB Stick: Contains a configeration file, sound and map files.

## A. The Hardware
The latest system is working with a RaspberryPi V2 Model B with debian Wheezy. the system has also been tested with a beagleboard xM. We got the system working with a Beagle Bone Black though we experienced audio glitches so recommend using the Raspberry Pi. To Build a complete system we used:

- RaspberyPi V2 Model B.
- 12v Amp + speakers.
- 12v battery. 
- Usb GPS device, we have used: G-START IV.
- 12v to 5v convertor to power the Raspberry pi from the 12v battery. 
- Fast 8GB (or more) USB Stick.


## B. Operating System

### SPECIFIC " Beagleboard xM" INSTRUCTIONS
Has been tested with and works for: Debian: Linux arm 4.0.2-armv7

Download a prebuilt Debian image and verify the image:

	$ wget https://rcn-ee.com/rootfs/2015-05-08/microsd/bbxm-debian-8.0-console-armhf-2015-05-08-2gb.img.xz
	$ md5sum bbxm-debian-8.0-console-armhf-2015-05-08-2gb.img.xz 13371bcf77921b5955c02b91d3a49534 bbxm-debian-8.0-console-armhf-2015-05-08-2gb.img.xz

Uncompress:

	$ unxz bbxm-debian-8.0-console-armhf-2015-05-08-2gb.img.xz

Then burn to an SD card:

	$ sudo dd bs=4M if=bbxm-debian-8.0-console-armhf-2015-05-08-2gb.img of=/dev/XXX

Login to the beagleboard xM and resize the partition (debian pass: temppwd):

	$ cd /opt/scripts/tools
	$ git pull
	$ ./grow_partition.sh
	$ sudo reboot
	
Now update the OS and install your favourite text editor (I like vim):

	$ sudo apt-get update
	$ sudo apt-get install vim

## C. The Software
Move to sonic home directory and download the init scripts:

	$ cd ~
	$ git clone https://github.com/sonicbikes/sonic-bike-init.git

And download the 'finding song' version of the app:

	$ git clone https://github.com/sonicbikes/app-findingsong.git

And some test audio along with a config file:

	$ git clone https://github.com/sonicbikes/testaudio.git

Finally, to make the system auto-start:

	$ sudo cp ~/sonic-bike-init/sonic-bike.service  /etc/systemd/system/sonic-bike.service
	$ sudo systemctl enable sonic-bike.service

## D. Prep a USB Stick

Now prepare a USB stick to mount/save all the audio. First format it as FAT32 then plug into the device and: 

	$ mkdir /home/sonic/audio
	
And check its visible to the OS and mount to the audio directory. replace XXX with the name of the USB stick in "/dev". The Begleboard xM loads it to "/dev/sda1":

	$ lsusb
	$ sudo mount /dev/XXX audio -o umask=000
	
Now download some test audio and move to the USB stick:

	$ cd /home/sonic/testaudio
	$ sudo mv config.json labsounds ../audio/

And check audio output is working by playing a sound:

	$ aplay /home/sonic/audio/testlab/sound/accordionsolo1Hi.wav 

Install pre-requisites and test the startup:

	 $ sudo apt-get install  lua5.1 lua-posix lua-socket
	 $ cd /home/sonic/app-findingsong/src
	 $ sudo ./swamp

Finally, to make the system auto-start:

	$ sudo cp ~/sonic-bike-init/sonic-bike.service  /etc/systemd/system/sonic-bike.service
	$ sudo systemctl enable sonic-bike.service
	$ sudo systemctl start sonic-bike.service

Now you should hear some audio... And if you reboot the system, everything should start automagically:

	$ Sudo reboot

Archived Instructions
============================
Soem snippets that have helped us to install the software which may or may not be usefull. 

### For the Beagle Bone Black
Check if you are running kernel version "3.8.13-bone47":

    $ uname -a
    
If you have an earler or later version then we can't be sure that things will work properly as we found errors with audio playback in later versions of the kernal. To install the correct version of the kernel, as root (not sudo). You may need to perform these actions while within an SD card as there needs to be space to download large files:

    $ wget https://github.com/RobertCNelson/linux-dev/archive/3.8.13-bone47.tar.gz
    $ gunzip 3.8.13-bone47.tar.gz
    $ tar -xvf 3.8.13-bone47.tar
    $ cd linux-dev-3.8.13-bone47
    $ sudo apt-get install bc lzma lzop libncurses5-dev 
    $ ./build_deb.sh
