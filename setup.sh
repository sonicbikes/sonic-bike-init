# General helper script
# When connected via USB run this script in order to:

# Grab a shared internet connection if we are plugged into USB
/sbin/route add default gw 192.168.7.1
echo "nameserver 8.8.8.8" >> /etc/resolv.conf

# Create some enviromental variables to enable cross compiling using distcc
export DISTCC_HOSTS=192.168.7.1/4
export DISTCC_BACKOFF_PERIOD=0
export DISTCC_IO_TIMEOUT=3000
export DISTCC_SKIP_LOCAL_RETRY=1
export CC=/usr/local/bin/gcc

# And mount the sd card
mount -t vfat -o defaults,rw,umask=0 /dev/mmcblk0p1 /home/sonic/sdcard

# Make all files editable
chmod 777 /home/sonic/sdcard -R   

# Set the time
ntpdate -b -s -u pool.ntp.org
