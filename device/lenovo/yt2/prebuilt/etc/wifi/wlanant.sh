#lenovo zhanghl4, use to test MIMO anttena.

ant=`getprop wlan.test.shell`


LOG_TAG="wlan-anttest"
LOG_NAME="${0}:"


loge ()
{
	/system/bin/log -t $LOG_TAG -p e "$LOG_NAME $@"
}

logi ()
{
	/system/bin/log -t $LOG_TAG -p i "$LOG_NAME $@"
}


logi "ant:$ant"


open ()
{
	rmmod bcm43241
	insmod /lib/modules/bcm43241.ko firmware_path=/system/etc/firmware/db_fw_bcmdhd.bin_43241_b4 nvram_path=/system/etc/firmware/db_bcmdhd_aob.cal_43241_b4
	if [ $? -ne 0 ]; then
		loge "insmod failed!!!!"
		exit 0
	fi
	logi "insmod successful!!!!"

	ifconfig wlan0 up
	if [ $? -ne 0 ]; then
		loge "ifconfig up failed!!!!"
		exit 0
	fi
	logi "ifconfig up successful!!!!"
}

close ()
{
	ifconfig wlan0 down
	if [ $? -ne 0 ]; then
		loge "ifconfig down failed!!!!"
		exit 0
	fi
	logi "ifconfig down successful!!!!"
	
	rmmod bcm43241
	if [ $? -ne 0 ]; then
		loge "rmmod failed!!!!"
		exit 0
	fi
	logi "rmmod successful!!!!"
	insmod /lib/modules/bcm43241.ko firmware_path=/system/etc/firmware/fw_bcmdhd.bin_43241_b4 nvram_path=/system/etc/firmware/bcmdhd_aob.cal_43241_b4
}


#ANT test Start

if [ ant -eq 2 ]; then
	logi "ANT1 test start"
else
	logi "ANT2 test start"
fi

#open WLAN
open

wlx ver
wlx mpc 0
wlx btc_mode 0

#select antenna
if [ ant -eq 2 ]; then
	wlx txchain 1
	wlx rxchain 1
else
	wlx txchain 2
	wlx rxchain 2
fi

#start scan
wlx scan

loop=0
while [ $loop -lt 10 ]
do
	logi "for the $loop "
	sleep 1
#get scan results
	wlx scanresults > /data/WlanAnt.log
	if [ -s /data/WlanAnt.log ]
	then
		break;
	fi
	loop=$(($loop+1))
done
chmod 644 /data/WlanAnt.log

#close WLAN
close

setprop wlan.test.shell 4

if [ ant -eq 2 ]; then
	logi "ANT1 test end"
else
	logi "ANT2 test end"
fi

exit 0
