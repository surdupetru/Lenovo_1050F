echo "wlanmode"

LOG_TAG="wlan-rftest"
LOG_NAME="${0}:"


loge ()
{
        /system/bin/log -t $LOG_TAG -p e "$LOG_NAME $@"
}

logi ()
{
        /system/bin/log -t $LOG_TAG -p i "$LOG_NAME $@"
}

wlanmode=`getprop wlan.test.shell`
logi "wlanmode=$wlanmode"

if [ "$wlanmode" = "insmodnormal" ]; then
  logi "insmod"
	insmod /lib/modules/bcm43241.ko firmware_path=/system/etc/firmware/fw_bcmdhd.bin_43241_b4 nvram_path=/system/etc/firmware/bcmdhd_aob.cal_43241_b4
	logi "insmod successful!!!!"
	setprop wlan.test.shell "insmodOK"
	exit
fi

if [ "$wlanmode" = "rmmodnormal" ]; then
  logi "rmmod"
	rmmod bcm43241
	logi "rmmod successful!!!!"
	setprop wlan.test.shell "rmmodOK"
	exit
fi


 
mode=`getprop wlan.test.mode`
ht=`getprop wlan.test.ht`
band=`getprop wlan.test.band`
sgi=`getprop wlan.test.sgi`
rate=`getprop wlan.test.rate`
ant=`getprop wlan.test.ant`
power=`getprop wlan.test.power`
channel=`getprop wlan.test.channel`

LOG_TAG="wlan-rftest"
LOG_NAME="${0}:"

logi "mode:$mode"
logi "ht:$ht"
logi "band:$band"
logi "sgi:$sgi"
logi "rate:$rate"
logi "ant:$ant"
logi "power:$power"
logi "channel:$channel"

open ()
{
	rmmod bcm43241
	insmod /lib/modules/bcm43241.ko firmware_path=/system/etc/firmware/db_fw_bcmdhd.bin_43241_b4 nvram_path=/system/etc/firmware/db_bcmdhd_aob.cal_43241_b4
	if [ $? -ne 0 ]; then
		loge "insmod failed!!!!"
		exit 0
	fi
	logi "insmod successful!!!!"
	setprop wlan.test.result 17
	ifconfig wlan0 up
	if [ $? -ne 0 ]; then
		loge "ifconfig up failed!!!!"
		exit 0
	fi
	logi "ifconfig up successful!!!!"
	setprop wlan.test.result 34
}

close ()
{
	ifconfig wlan0 down
	if [ $? -ne 0 ]; then
		loge "ifconfig down failed!!!!"
		exit 0
	fi
	logi "ifconfig down successful!!!!"
	setprop wlan.test.result 40
	
	rmmod bcm43241
	if [ $? -ne 0 ]; then
		loge "rmmod failed!!!!"
		exit 0
	fi
	logi "rmmod successful!!!!"
	setprop wlan.test.result 60
	insmod /lib/modules/bcm43241.ko firmware_path=/system/etc/firmware/fw_bcmdhd.bin_43241_b4 nvram_path=/system/etc/firmware/bcmdhd_aob.cal_43241_b4
	setprop wlan.test.result 80
	
}

resume ()
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

#TX Start
if [ mode -eq 1 ]; then
	logi "mode is TX start"
	open
	wlx ver
	wlx phy_oclscdenable 2
	wlx mpc 0
	sleep 2
	setprop wlan.test.result 51
	wlx down
	wlx country ALL
	wlx phy_watchdog 0
	wlx scansuppress 1
	wlx mimo_preamble 0
	if [ ht -eq 20 ]; then
		logi "set bw 20"
		wlx mimo_bw_cap 0
		wlx mimo_txbw -1
	else
		logi "set bw 40"
		wlx mimo_bw_cap 1
		wlx mimo_txbw 4
	fi
	wlx band $band
	wlx chanspec $channel
	wlx up
	sleep 1
	setprop wlan.test.result 68
	wlx chanspec
	wlx sgi_tx $sgi
	wlx $rate

	if [ ant -eq 1 ]; then
		logi "set ant 1"
		wlx txant 0
		wlx txchain 1
		wlx rxchain 1
		wlx antdiv 0
	elif [ ant -eq 2 ]; then
		logi "set ant 1"
		wlx txant 1
		wlx txchain 2
		wlx rxchain 2
		wlx antdiv 1
	else
		logi "set ant MIMO"
		wlx txchain 3
		wlx rxchain 3
	fi
	
	wlx pkteng_stop tx
	wlx phy_forcecal 1
	sleep 2
	setprop wlan.test.result 85
	wlx txpwr1 -o -d $power
	wlx pkteng_start 00:11:22:33:44:55 tx 100 1500 0
	if [ $? -eq 0 ]; then
		loge "rftest TX Start successful!!!!"
		setprop wlan.test.result 100
	else
		loge "rftest TX Start ERROR!!!!"
		setprop wlan.test.result 200
		resume
	fi
	
	
	
#TX Stop
elif [ mode -eq 2 ]; then
	logi "mode is TX stop"
	wlx pkteng_stop tx
	wlx down
	setprop wlan.test.result 20
	if [ $? -eq 0 ]; then
		loge "rftest TX Stop successful!!!!"
		close
		setprop wlan.test.result 100
	else
		loge "rftest TX Stop ERROR!!!!"
		setprop wlan.test.result 200
		resume
	fi
	
	
#RX Start
elif [ mode -eq 3 ]; then
	logi "mode is RX start"
	open
	wlx ver
	wlx phy_oclscdenable 2
	wlx mpc 0
	sleep 2
	setprop wlan.test.result 51
	wlx down
	wlx country ALL
	wlx phy_watchdog 0
	wlx scansuppress 1
	wlx mimo_preamble 0
	if [ ht -eq 20 ]; then
		logi "set bw 20"
		wlx mimo_bw_cap 0
		wlx mimo_txbw -1
	else
		logi "set bw 40"
		wlx mimo_bw_cap 1
		wlx mimo_txbw 4
	fi
	wlx band $band
	wlx chanspec $channel
	wlx up
	sleep 1
	setprop wlan.test.result 68
	wlx chanspec
	wlx sgi_tx $sgi
	wlx $rate

	if [ ant -eq 1 ]; then
		logi "set ant 1"
		wlx txant 0
		wlx txchain 1
		wlx rxchain 1
		wlx antdiv 0
	elif [ ant -eq 2 ]; then
		logi "set ant 1"
		wlx txant 1
		wlx txchain 2
		wlx rxchain 2
		wlx antdiv 1
	else
		logi "set ant MIMO"
		wlx txchain 3
		wlx rxchain 3
	fi
	
	wlx pkteng_stop tx
	wlx phy_forcecal 1
	sleep 2
	setprop wlan.test.result 85
	wlx pkteng_start 00:11:22:33:44:55 rx
	if [ $? -eq 0 ]; then
		wlx counters > /data/wlan_rftest.log
		chmod 777 /data/wlan_rftest.log
		loge "rftest RX Start successful!!!!"
		setprop wlan.test.result 100
	else
		loge "rftest RX Start ERROR!!!!"
		setprop wlan.test.result 200
		resume
	fi
	
	
#RX Stop
elif [ mode -eq 4 ]; then
	logi "mode is RX stop"
	wlx counters > /data/wlan_rftest.log
	chmod 777 /data/wlan_rftest.log
	wlx pkteng_stop rx
	wlx down
	setprop wlan.test.result 20
	if [ $? -eq 0 ]; then
		loge "rftest RX Stop successful!!!!"
		close
		setprop wlan.test.result 100
	else
		loge "rftest RX Stop ERROR!!!!"
		setprop wlan.test.result 200
		resume
	fi

#start CW
elif [ mode -eq 5 ]; then
	logi "mode is CW start"
	open
	wlx down
	wlx mpc 0
	wlx up
	wlx band $band
	wlx up
	wlx out
	wlx fqacurcy $channel

#stop CW
elif [ mode -eq 6 ]; then
	logi "mode is CW stop"
	wlx down
	close
fi




exit 0
