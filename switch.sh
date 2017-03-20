#!/bin/bash
cd `dirname $0`

#Control a Edimax SP-1101W Smarthome-Switch with this script
#Usage: switch.sh <ip> <on/off/status>
#Set Username and Password for the Ediplug
username="admin"
password="1234"

if [ "$2" = "toggle" ]; then
	state=`cat state_$1.txt`
	if [[ $state == "ON" ]]; then
		#Is on, switching off
		output=`curl --silent -d @off.xml http://$username:$password@$1:10000/smartplug.cgi`
		echo "OFF" > state_$1.txt
	else
		#Is off, switching on
		output=`curl --silent -d @on.xml http://$username:$password@$1:10000/smartplug.cgi`
		echo "ON" > state_$1.txt
	fi
elif [ "$2" = "status" ]; then
	echo $output | grep -oPm1 "(?<=<Device.System.Power.State>)[^<]+" > state_$1.txt
else
	output=`curl --silent -d @$2.xml http://$username:$password@$1:10000/smartplug.cgi`
	echo $2 > state_$1.txt
fi

cp state_$1.txt /var/www/states/light_$1.txt
