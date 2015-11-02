#
# Copyright (C) 2011 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Inherit the blue-common definitions
$(call inherit-product, device/sony/blue-common/blue.mk)

DEVICE_PACKAGE_OVERLAYS += device/sony/tsubasa/overlay

# These are the hardware-specific features
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.telephony.cdma.xml:system/etc/permissions/android.hardware.telephony.cdma.xml

# This device is xhdpi.  However the platform doesn't
# currently contain all of the bitmaps at xhdpi density so
# we do this little trick to fall back to the hdpi version
# if the xhdpi doesn't exist.
PRODUCT_AAPT_CONFIG := normal hdpi xhdpi
PRODUCT_AAPT_PREF_CONFIG := xhdpi

# HW Settings
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/system/etc/pre_hw_config.sh:system/etc/pre_hw_config.sh \
    $(LOCAL_PATH)/rootdir/system/etc/hw_config.sh:system/etc/hw_config.sh

# Wifi
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/prima/WCNSS_cfg.dat:system/etc/firmware/wlan/prima/WCNSS_cfg.dat \
    $(LOCAL_PATH)/rootdir/prima/WCNSS_qcom_wlan_nv.bin:system/etc/firmware/wlan/prima/WCNSS_qcom_wlan_nv.bin

# Sensors
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/system/etc/sensors.conf:system/etc/sensors.conf

# Sysmon
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/system/etc/sysmon.cfg:system/etc/sysmon.cfg

# Touchscreen
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/system/usr/idc/sensor00_f11_sensor0.idc:system/usr/idc/sensor00_f11_sensor0.idc

# Device specific init
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/init.device.rc:root/init.device.rc

# USB function switching
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/init.sony.usb.rc:root/init.sony.usb.rc

PRODUCT_PROPERTY_OVERRIDES += \
	persist.sys.usb.config=mtp,adb \
	persist.sys.isUsbOtgEnabled=true

ADDITIONAL_DEFAULT_PROPERTIES += \
	ro.semc.version.sw=1266-3320 \
	ro.semc.version.sw_revision=9.2.A.1.215 \
	ro.semc.version.sw_variant=GENERIC \
	ro.semc.version.sw_type=user \
	ro.adb.secure=0 \
	ro.secure=0 \
	ro.allow.mock.location=1 \
	persist.sys.root_access=1

PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/recovery/root/sepolicy:recovery/root/sepolicy

# Hijack boot
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/system/etc/init.qcom.modem_links.sh:system/etc/init.qcom.modem_links.sh \
    $(LOCAL_PATH)/rootdir/hijack/hijack.sh:system/bin/hijack/hijack.sh
	
$(call inherit-product, frameworks/native/build/phone-xhdpi-1024-dalvik-heap.mk)

PRODUCT_PACKAGES += \
    libtime_genoff

# Include non-opensource parts
$(call inherit-product, vendor/sony/tsubasa/tsubasa-vendor.mk)
