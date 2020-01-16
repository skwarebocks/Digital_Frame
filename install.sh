#!/bin/bash

#update raspbian

sudo apt-get update -y
sudo apt-get upgrade -y

#install and configure dnsmasq and hostapd
sudo apt-get install hostapd dnsmasq -y
sudo update-rc.d dnsmasq disable
sudo update-rc.d hostapd disable
sudo systemctl unmask hostapd.service

#install and configure apache2
sudo apt install apache2 -y
sudo tee -a /etc/apache2/apache2.conf >> /dev/null <<EOT
<Directory "/usr/lib/cgi-bin">
    AllowOverride None
    Options None
    Require all granted	
    Options +ExecCGI
    AddHandler cgi-script .cgi .pl .py
</Directory>
EOT

#install PHP
sudo apt install php libapache2-mod-php -y

#install feh and dependencies (image software)
sudo apt-get install feh -y
sudo  tee -a /home/pi/.xession > /dev/null <<EOT
xset s noblank
xset s off
xset -dpms
feh -F -Z -z -D 120 --auto-rotate /var/wwww/html/photos
EOT

#install git
sudo apt-get install git -y

#download repo and move folders.
sudo git clone https://github.com/skwarebocks/Digital_Frame.git
sudo mkdir /home/pi/wificonfig
sudo cp /home/pi/Digital_Frame/button.py /home/pi/wificonfig/button.py
sudo cp /home/pi/Digital_Frame/wificonfig.py /usr/lib/cgi-bin/wificonfig.py
sudo cp /home/pi/Digital_Frame/dnsmasq.conf /etc/dnsmasq.conf
sudo cp /home/pi/Digital_Frame/buttoncron /etc/cron.d/buttoncron
sudo cp -r /home/pi/Digital_Frame/supportingfiles /home/pi/wificonfig
sudo cp -r /home/pi/Digital_Frame/images /home/pi/wificonfig
sudo cp -r /home/pi/Digital_Frame/html /var/www
sudo rm /var/www/html/index.html

ifconfig
echo "**********************************************************"
echo "**********************************************************"
echo "Make note of wifi mac address above and update file: /etc/dnsmasq.conf"
echo "Reboot when finished."
echo "**********************************************************"
echo "**********************************************************"
