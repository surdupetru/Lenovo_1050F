typeset -u ccode
sleep 3
ccode=`getprop ro.product.countrycode`

if [ ! -n "$ccode" ]; then
	ccode=CN
fi

LOG_TAG="wlan-ccode"
LOG_NAME="${0}:"


loge ()
{
        /system/bin/log -t $LOG_TAG -p e "$LOG_NAME $@"
}

logi ()
{
        /system/bin/log -t $LOG_TAG -p i "$LOG_NAME $@"
}

cp /system/etc/wifi/bcmdhd_aob.cal_43241_b4 /data/misc/wifi/bcmdhd_aob.cal_43241_b4
chmod 660 /data/misc/wifi/bcmdhd_aob.cal_43241_b4
chown system:wifi /data/misc/wifi/bcmdhd_aob.cal_43241_b4
cp /system/etc/wifi/ccode /data/misc/wifi/ccode
chmod 644 /data/misc/wifi/ccode
chown system:wifi /data/misc/wifi/ccode

if [ "$ccode" = "UK" ]; then
ccode="GB"
fi

if [ "$ccode" = "SA" ]; then
ccode="AE"
fi

regrev=$(grep -a $ccode /data/misc/wifi/ccode | awk -F':' '{print $2}')

logi "ccode=$ccode,regrev=$regrev"

src_text=`sed -n '/ccode/p' /data/misc/wifi/bcmdhd_aob.cal_43241_b4`
logi "old_ccode=$src_text"
des_text="ccode="${ccode}
logi "new ccode=$des_text"
sed -i "s/$src_text/$des_text/g"  /data/misc/wifi/bcmdhd_aob.cal_43241_b4

src_text=`sed -n '/regrev/p' /data/misc/wifi/bcmdhd_aob.cal_43241_b4`
logi "old regrev=$src_text"
des_text="regrev="${regrev}
logi "new regrev=$des_text"
sed -i "s/$src_text/$des_text/g"  /data/misc/wifi/bcmdhd_aob.cal_43241_b4

