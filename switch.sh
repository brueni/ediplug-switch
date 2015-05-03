#!/bin/bash
cd `dirname $0`

#Control a Edimax SP-1101W Smarthome-Switch with this script
#Usage: switch.sh <ip> <on/off/status>
#Set Username and Password for the Ediplug
username="admin"
password="1234"

curl -d @$2.xml http://$username:$password@$1:10000/smartplug.cgi
