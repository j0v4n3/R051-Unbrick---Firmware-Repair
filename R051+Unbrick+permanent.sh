#!/bin/sh
jffs2reset -y
fw_setenv dropbear_mode
fw_setenv dropbear_password
fw_setenv dropbear_key_type

wget  https://github.com/j0v4n3/R051-Unbrick---Firmware-Repair/blob/main/firmware.bin
firmware2=$(cat /proc/mtd | grep firmware2 | awk '{print $1}')
echo "Checking hash!"
hash=$(md5sum /tmp/firmware.bin | awk '{print $1}')
echo "$hash =e6ca46ae78299db36cc3f1db36bca484"
if [ $hash == 'e6ca46ae78299db36cc3f1db36bca484' ]
then
echo "Same!"
echo "InstallingPlease Wait!!!."
echo "Firmware upgrading on process..."
if [ $firmware2 == 'mtd7:' ];
then
echo "Wait for the modem to reboot..."
mtd -r write /tmp/firmware.bin /dev/mtd4
exit
fi
echo "Wait for the modem to reboot..."
mtd -r write /tmp/firmware.bin /dev/mtd5
exit
else
echo "Not same!"
fi