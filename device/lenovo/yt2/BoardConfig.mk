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

# inherit from the proprietary version
#-include vendor/lenovo/yt2/BoardConfigVendor.mk

TARGET_DEVICE := yt2

LOCAL_PATH := device/lenovo/yt2

USE_CAMERA_STUB := false

# Audio
TARGET_PROVIDES_LIBAUDIO := true
BOARD_USES_GENERIC_AUDIO := true

TARGET_NO_BOOTLOADER := true
TARGET_BOARD_PLATFORM := baylake

TARGET_ARCH := x86
TARGET_CPU_ABI := x86
TARGET_CPU_ABI2 := armeabi-v7a
TARGET_CPU_SMP := true
TARGET_ARCH_VARIANT := x86
TARGET_CPU_VARIANT := x86

-include build/core/combo/arch/x86/x86-atom.mk

TARGET_BOOTLOADER_BOARD_NAME := yt2

# Wifi related defines

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(LOCAL_PATH)/bluetooth

# adb has root
ADDITIONAL_DEFAULT_PROPERTIES += ro.secure=0
ADDITIONAL_DEFAULT_PROPERTIES += ro.allow.mock.location=1
ADDITIONAL_DEFAULT_PROPERTIES += persist.sys.usb.config=mass_storge,mtp

# Graphics
BOARD_EGL_CFG := $(LOCAL_PATH)/prebuilt/lib/egl/egl.cfg
USE_OPENGL_RENDERER := true

# Webkit
ENABLE_WEBGL := true
TARGET_FORCE_CPU_UPLOAD := true

# Kernel
BOARD_KERNEL_CMDLINE := console=logk0 earlyprintk=nologger loglevel=4 ptrace.ptrace_can_access=1 nmi_watchdog=panic softlockup_panic=1 androidboot.bootmedia=sdcard androidboot.hardware=byt_t_ffrd8 watchdog.watchdog_thresh=60 androidboot.spid=xxxx:xxxx:xxxx:xxxx:xxxx:xxxx androidboot.serialno=01234567890123456789 oops=panic panic=40 vmalloc=480M vga=current i915.modeset=1 drm.vblankoffdelay=1 acpi_backlight=vendor i915.i915_rotation=1 i915.mipi_panel_id=3
BOARD_KERNEL_BASE := 0x80000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_MKBOOTIMG_ARGS := --ramdisk_offset 0x81000000

BOARD_KERNEL_IMAGE_NAME := bzImage
USE_INTEL_JPEGDEC := true

# kernel build
TARGET_PREBUILT_KERNEL := $(LOCAL_PATH)/kernel

TARGET_OTA_ASSERT_DEVICE := yt2,YT2

# USB mass storage
TARGET_USE_CUSTOM_LUN_FILE_PATH := "/sys/devices/virtual/android_usb/android0/f_mass_storage/lun/file"
BOARD_VOLD_MAX_PARTITIONS := 23

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE := 16777216
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 20971520
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 2147483648
BOARD_USERDATAIMAGE_PARTITION_SIZE := 12256784384

BOARD_SEPOLICY_DIRS += device/lenovo/yt2/sepolicy

BOARD_SEPOLICY_UNION += \
    device.te \
    file_contexts \
    gpu_device.te

# Recovery
TARGET_RECOVERY_FSTAB := $(LOCAL_PATH)/rootdir/twrp.fstab
BOARD_CUSTOM_RECOVERY_KEYMAPPING := $(LOCAL_PATH)/rootdir/recovery_keys.c

TARGET_PREBUILT_RECOVERY_KERNEL := $(LOCAL_PATH)/recovery-kernel
TARGET_RECOVERY_INITRC := $(LOCAL_PATH)/rootdir/init.rc

TARGET_RECOVERY_PIXEL_FORMAT := "BGRA_8888"
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_HAS_SDCARD_INTERNAL := true
BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_FLASH_BLOCK_SIZE := 131072
DEVICE_RESOLUTION := 1920x1200
RECOVERY_FSTAB_VERSION := 2
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_USE_CUSTOM_RECOVERY_FONT := \"roboto_15x24.h\"
BOARD_RECOVERY_SWIPE := true
HAVE_SELINUX := true
TW_MAX_BRIGHTNESS := 255
RECOVERY_GRAPHICS_USE_LINELENGTH := true
RECOVERY_SDCARD_ON_DATA := true 
TW_HAS_MTP := true
TW_NO_USB_STORAGE := true
TW_ALWAYS_RMRF := true
TW_FLASH_FROM_STORAGE := true
TW_DEFAULT_EXTERNAL_STORAGE := true
TW_EXTERNAL_STORAGE_PATH := "/external_sd"
TW_EXTERNAL_STORAGE_MOUNT_POINT := "external_sd"
TW_INTERNAL_STORAGE_PATH := "/data/media"
TW_INTERNAL_STORAGE_MOUNT_POINT := "data"
TW_CUSTOM_BATTERY_PATH := "/sys/class/power_supply/battery"
TW_BRIGHTNESS_PATH := "/sys/class/backlight/intel_backlight/brightness"
