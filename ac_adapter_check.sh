#!/bin/bash

#script to probe for AC power and shuts off the  system if none.
#should be ran at startup with root privileges
#use crontab -e -u root
#add line @reboot /path/to/script/here
#modify your path to a log file. Use /dev/null for no logs

LOGPATH=/testing/ac_adapter/adapter_shutdown.log

echo "$(date)": System just booted. Starting script. >> $LOGPATH
while :
do
	sleep 8m
	if [ "$(acpi -a | cut -d' ' -f3 | cut -d- -f1)" = "off" ]; then
		echo "$(date)": AC pwr unplugged. Waiting 4 minutes before rechecking. >> $LOGPATH
		sleep 4m
		if [ "$(acpi -a | cut -d' ' -f3 | cut -d- -f1)" = "off" ]; then
			echo "$(date)": ****AC pwr still unplugged. Shutting down**** >> $LOGPATH
			sudo /usr/sbin/shutdown now
		else
			echo "$(date)": **AC pwr restored before timeout** >> $LOGPATH

		fi
	fi

done
