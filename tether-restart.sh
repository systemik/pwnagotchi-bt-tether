#!/bin/sh

SCRIPT=$(readlink -f $0)
SCRIPTPATH=`dirname $SCRIPT`

/sbin/ifconfig bnep0 > /dev/null 2>&1
status=$?
if [ $status -ne 0 ]; then
	echo "Connecting to bluetooth"
	sudo systemctl restart btnap

	sleep 10
	sudo ifconfig bnep0 192.168.44.100 netmask 255.255.255.0
	sudo sed -i "s@127.0.0.1@8.8.8.8@g" /etc/resolv.conf
	sudo route del -net 0.0.0.0 netmask 0.0.0.0 gw 10.0.0.1
	sudo route add -net 0.0.0.0 netmask 0.0.0.0 gw 192.168.44.1
fi
