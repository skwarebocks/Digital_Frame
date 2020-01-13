#!/usr/bin/python
import cgi
import os
import time
print("Content-type: text/html\n")

abspath = '/var/www/html'

form = cgi.FieldStorage()
wifi_name = form.getvalue('wifi_name')
wifi_pass = form.getvalue('wifi_pass')
wpa_supplicant = ["country=US\n", "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev\n", "update_config=1\n\n", "network={\n", '\tssid="%s"\n' % wifi_name, '\tpsk="%s"\n' % wifi_pass, "}"]
fh = open ("wpa_supplicant.conf","w")
fh.writelines (wpa_supplicant)
fh.close ()

print ("<!DOCTYPE html>\r\n<html>\r\n<head>\r\n<title>Digital Frame</title>\r\n<meta http-equiv = \"refresh\" content = \"0; url = http://10.0.0.1/wificonfig/confirm.html\" />\r\n</head>\r\n<body>\r\n<p>Processing...</p>\r\n</body>\r\n</html>")

os.system ('sudo mv wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf')
os.system ('sudo cp /home/pi/wificonfig/supportingfiles/interfaces.bak /etc/network/interfaces')
os.system ('sudo /usr/bin/fbi -d /dev/fb0 -T 1 --noverbose /home/pi/images/wificonfigcomplete.png')

time.sleep ( 2 )
os.system ('sudo reboot')
