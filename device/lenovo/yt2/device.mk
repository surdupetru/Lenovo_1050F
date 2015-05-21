#
# Copyright (C) 2014 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# Overlay
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

ifeq ($(TARGET_PREBUILT_KERNEL),)
	LOCAL_KERNEL := $(LOCAL_PATH)/kernel
else
	LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

# Recovery
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/system/bin/linker:recovery/root/system/bin/linker \
    $(LOCAL_PATH)/rootdir/system/lib/libc.so:recovery/root/system/lib/libc.so \
    $(LOCAL_PATH)/rootdir/system/lib/libcutils.so:recovery/root/system/lib/libcutils.so \
    $(LOCAL_PATH)/rootdir/system/lib/liblog.so:recovery/root/system/lib/liblog.so \
    $(LOCAL_PATH)/rootdir/system/lib/libm.so:recovery/root/system/lib/libm.so \
    $(LOCAL_PATH)/rootdir/system/lib/libselinux.so:recovery/root/system/lib/libselinux.so \
    $(LOCAL_PATH)/rootdir/system/lib/libstdc++.so:recovery/root/system/lib/libstdc++.so \
    $(LOCAL_PATH)/rootdir/system/lib/libusbhost.so:recovery/root/system/lib/libusbhost.so \
    $(LOCAL_PATH)/rootdir/system/xbin/strace:recovery/root/system/xbin/strace

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/lib/modules/atomisp-css2400b0_v21.ko:recovery/root/lib/modules/atomisp-css2400b0_v21.ko \
    $(LOCAL_PATH)/rootdir/lib/modules/atomisp-css2401a0_legacy_v21.ko:recovery/root/lib/modules/atomisp-css2401a0_legacy_v21.ko \
    $(LOCAL_PATH)/rootdir/lib/modules/atomisp-css2401a0_v21.ko:recovery/root/lib/modules/atomisp-css2401a0_v21.ko \
    $(LOCAL_PATH)/rootdir/lib/modules/bcm43241.ko:recovery/root/lib/modules/bcm43241.ko \
    $(LOCAL_PATH)/rootdir/lib/modules/bcm_bt_lpm.ko:recovery/root/lib/modules/bcm_bt_lpm.ko \
    $(LOCAL_PATH)/rootdir/lib/modules/hdmi_audio.ko:recovery/root/lib/modules/hdmi_audio.ko \
    $(LOCAL_PATH)/rootdir/lib/modules/imx1x5.ko:recovery/root/lib/modules/imx1x5.ko \
    $(LOCAL_PATH)/rootdir/lib/modules/iqvandroid.ko:recovery/root/lib/modules/iqvandroid.ko \
    $(LOCAL_PATH)/rootdir/lib/modules/libmsrlisthelper.ko:recovery/root/lib/modules/libmsrlisthelper.ko \
    $(LOCAL_PATH)/rootdir/lib/modules/lm3554.ko:recovery/root/lib/modules/lm3554.ko \
    $(LOCAL_PATH)/rootdir/lib/modules/mac80211.ko:recovery/root/lib/modules/mac80211.ko \
    $(LOCAL_PATH)/rootdir/lib/modules/modules.alias:recovery/root/lib/modules/modules.alias \
    $(LOCAL_PATH)/rootdir/lib/modules/modules.alias.bin:recovery/root/lib/modules/modules.alias.bin \
    $(LOCAL_PATH)/rootdir/lib/modules/modules.ccwmap:recovery/root/lib/modules/modules.ccwmap \
    $(LOCAL_PATH)/rootdir/lib/modules/modules.dep:recovery/root/lib/modules/modules.dep \
    $(LOCAL_PATH)/rootdir/lib/modules/modules.dep.bin:recovery/root/lib/modules/modules.dep.bin \
    $(LOCAL_PATH)/rootdir/lib/modules/modules.devname:recovery/root/lib/modules/modules.devname \
    $(LOCAL_PATH)/rootdir/lib/modules/modules.ieee1394map:recovery/root/lib/modules/modules.ieee1394map \
    $(LOCAL_PATH)/rootdir/lib/modules/modules.inputmap:recovery/root/lib/modules/modules.inputmap \
    $(LOCAL_PATH)/rootdir/lib/modules/modules.isapnpmap:recovery/root/lib/modules/modules.isapnpmap \
    $(LOCAL_PATH)/rootdir/lib/modules/modules.ofmap:recovery/root/lib/modules/modules.ofmap \
    $(LOCAL_PATH)/rootdir/lib/modules/modules.pcimap:recovery/root/lib/modules/modules.pcimap \
    $(LOCAL_PATH)/rootdir/lib/modules/modules.seriomap:recovery/root/lib/modules/modules.seriomap \
    $(LOCAL_PATH)/rootdir/lib/modules/modules.softdep:recovery/root/lib/modules/modules.softdep \
    $(LOCAL_PATH)/rootdir/lib/modules/modules.symbols:recovery/root/lib/modules/modules.symbols \
    $(LOCAL_PATH)/rootdir/lib/modules/modules.symbols.bin:recovery/root/lib/modules/modules.symbols.bin \
    $(LOCAL_PATH)/rootdir/lib/modules/modules.usbmap:recovery/root/lib/modules/modules.usbmap \
    $(LOCAL_PATH)/rootdir/lib/modules/ov2722.ko:recovery/root/lib/modules/ov2722.ko \
    $(LOCAL_PATH)/rootdir/lib/modules/ov8865.ko:recovery/root/lib/modules/ov8865.ko \
    $(LOCAL_PATH)/rootdir/lib/modules/ov9760.ko:recovery/root/lib/modules/ov9760.ko \
    $(LOCAL_PATH)/rootdir/lib/modules/pax.ko:recovery/root/lib/modules/pax.ko \
    $(LOCAL_PATH)/rootdir/lib/modules/sep3_10.ko:recovery/root/lib/modules/sep3_10.ko \
    $(LOCAL_PATH)/rootdir/lib/modules/SOCWATCH1_3.ko:recovery/root/lib/modules/SOCWATCH1_3.ko \
    $(LOCAL_PATH)/rootdir/lib/modules/uvcvideo.ko:recovery/root/lib/modules/uvcvideo.ko \
    $(LOCAL_PATH)/rootdir/lib/modules/videobuf2-core.ko:recovery/root/lib/modules/videobuf2-core.ko \
    $(LOCAL_PATH)/rootdir/lib/modules/videobuf2-memops.ko:recovery/root/lib/modules/videobuf2-memops.ko \
    $(LOCAL_PATH)/rootdir/lib/modules/videobuf2-vmalloc.ko:recovery/root/lib/modules/videobuf2-vmalloc.ko \
    $(LOCAL_PATH)/rootdir/lib/modules/videobuf-core.ko:recovery/root/lib/modules/videobuf-core.ko \
    $(LOCAL_PATH)/rootdir/lib/modules/videobuf-vmalloc.ko:recovery/root/lib/modules/videobuf-vmalloc.ko \
    $(LOCAL_PATH)/rootdir/lib/modules/vtsspp.ko:recovery/root/lib/modules/vtsspp.ko \
    $(LOCAL_PATH)/rootdir/lib/modules/vxd392.ko:recovery/root/lib/modules/vxd392.ko

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/sbin/ia_watchdogd:recovery/root/sbin/ia_watchdogd \
    $(LOCAL_PATH)/rootdir/sbin/thermald:recovery/root/sbin/thermald \
    $(LOCAL_PATH)/rootdir/sbin/partlink:recovery/root/sbin/partlink 

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/charger:recovery/root/charger

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml

PRODUCT_PACKAGES += \
    init.baylake.sh \
    init.firmware.rc \
    init.watchdog.rc \
    init.watchdog.sh \
    ueventd.byt_t_ffrd8.rc

PRODUCT_PACKAGES += \
    fstab.byt_t_ffrd8

# This device have enough room for precise davick
PRODUCT_TAGS += dalvik.gc.type-precise

# Device uses ultra-high-density artwork where available
PRODUCT_AAPT_CONFIG := normal mdpi hdpi xhdpi
PRODUCT_AAPT_PREF_CONFIG := hdpi

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.root_access=3

PRODUCT_CHARACTERISTICS := sdcard

# Misc
PRODUCT_PACKAGES += \
    setup_fs \
    librs_jni \
    libsrec_jni \
    com.android.future.usb.accessory \
    make_ext4fs

# Live Wallpapers
PRODUCT_PACKAGES += \
    LiveWallpapers \
    LiveWallpapersPicker \
    VisualizationWallpapers

$(call inherit-product, build/target/product/full.mk)

# call dalvik heap config
$(call inherit-product-if-exists, frameworks/native/build/tablet-dalvik-heap.mk)
