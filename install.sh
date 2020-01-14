#!/bin/bash

#install and configure dnsmasq and hostapd
sudo apt-get install hostapd dnsmasq -y
sudo update-rc.d dnsmasq disable
sudo update-rc.d hostapd disable
sudo systemctl unmask hostapd.service

#install and configure PHP and apache2
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
sudo apt install php libapache2-mod-php -y

#install feh and dependencies (image software)
wget https://github.com/NautiluX/slide/releases/download/v0.9.0/slide_pi_stretch_0.9.0.tar.gz
tar xf slide_pi_stretch_0.9.0.tar.gz				
sudo mv slide_0.9.0/slide /usr/local/bin/
sudo apt install libexif12 qt5-default -y
mkdir -p /home/pi/.config/lxsession/LXDE/
sudo  tee -a /home/pi/.config/lxsession/LXDE/autostart > /dev/null <<EOT
xset s noblank
xset s off
xset -dpms
slide -p -t 60 -o 200 -p /var/wwww/html/digital_images
EOT

#download repo and move folders.
sudo git clone https://github.com/skwarebocks/Digital_Frame.git
sudo mkdir /home/pi/wificonfig
sudo mv ./Digital_Frame/button.py /home/pi/wificonfig/
sudo mv ./Digital_Frame/digitalframe.py /usr/lib/cgi-bin/
sudo mv ./Digital_Frame/dnsmasq.conf /etc/dnsmasq.conf
sudo mv ./Digital_Frame/buttoncron /etc/cron.d/buttoncron
sudo mv .Digital_Frame/supportingfiles /home/pi/wificonfig/
sudo mv .Digital_Frame/images /home/pi/wificonfig/
sudo mv .Digital_Frame/html /var/www/
sudo mv /home/pi/Digital_Frame /etc/cron.d/per_minute

ifconfig
echo "Make note of wifi mac address above and update file: /etc/dnsmasq.conf"
echo "Reboot when finished."