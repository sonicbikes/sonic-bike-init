Sonic Bike Init
============================

Scripts used to startup the sonic bike system.
Full instructions to follow...

Create a directory for the sd card to mount to
-----------------------------------------------------
    
    sudo mkdir /home/sonic/sdcard

This directory should contain a configeration file named config.json and folders containing audio files

Create a systemd service so conic bike auto starts
-----------------------------------------------------

    sudo ln -s /home/sonic/sonic-bike-init/sonic-bike.service /etc/systemd/system/sonic-bike.service

