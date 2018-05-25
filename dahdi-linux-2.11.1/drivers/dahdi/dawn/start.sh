#!/bin/sh
echo "start Dawn......"
killall -9 asterisk
sleep 2
rmmod wcanalog
sleep 1
insmod wcanalog.ko
sleep 1
dahdi_cfg -vvvv
killall -9 asterisk
sleep 1
asterisk -f 2 > /dev/null &

echo "done!!!"
