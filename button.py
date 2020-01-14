#!/usr/bin/env python
import RPi.GPIO as GPIO
import time
import os

GPIO.setmode(GPIO.BCM)

GPIO.setup(18, GPIO.IN, pull_up_down=GPIO.PUD_UP)
state = False

while True:
    input_state = GPIO.input(18)
    if input_state == False:
        if state == False:
                print('Turning on WIFI configurator')
                os.system('sudo pkil stretch')
                os.system('sudo /usr/bin/fbi -d /dev/fb0 -T 1 --noverbose /home/pi/images/wificonfig.png')
                os.system('sudo cp /home/pi/wificonfig/supportingfiles/interfaces.ap /etc/network/interfaces')
                os.system('sudo wpa_cli -i wlan0 flush')
                os.system('sudo ifup wlan0')
                os.system('sudo ifdown wlan0')
                os.system('sudo ifup wlan0')
                #os.system('sudo wpa_cli -i wlan0 flush')
                os.system('sudo service hostapd start')
                os.system('sudo service dnsmasq start')
              # os os.system('sudo python /usr/lib/cgi-bin/wificonfig.py')
                exit()
