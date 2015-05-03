#!/bin/bash
cd `dirname $0`

#Control a Edimax SP-1101W Smarthome-Switch with this script
#Usage: switch.sh <ip> <on/off/status>
#Set Username and Password for the Ediplug
username="admin"
password="1234"

output=`curl --silent -d @$2.xml http://$username:$password@$1:10000/smartplug.cgi`

if [ "$2" = "status" ]; then
	echo $output | grep -oPm1 "(?<=<Device.System.Power.State>)[^<]+" > state_$1.txt
else
	echo $2 > state_$1.txt
fi
