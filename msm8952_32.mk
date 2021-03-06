DEVICE_PACKAGE_OVERLAYS := device/qcom/msm8952_32/overlay

TARGET_USES_QCOM_BSP := true

# Add QC Video Enhancements flag
TARGET_ENABLE_QC_AV_ENHANCEMENTS := true
TARGET_USES_NQ_NFC := false
TARGET_USES_IMS := false

#QTIC flag
-include $(QCPATH)/common/config/qtic-config.mk

# Enable features in video HAL that can compile only on this platform
TARGET_USES_MEDIA_EXTENSIONS := true

# media_profiles and media_codecs xmls for msm8952
ifeq ($(TARGET_ENABLE_QC_AV_ENHANCEMENTS), true)
PRODUCT_COPY_FILES += device/qcom/msm8952_32/media/media_profiles_8952.xml:system/etc/media_profiles.xml \
                      device/qcom/msm8952_32/media/media_profiles_8956.xml:system/etc/media_profiles_8956.xml \
                      device/qcom/msm8952_32/media/media_codecs_8952.xml:system/etc/media_codecs.xml \
                      device/qcom/msm8952_32/media/media_codecs_8956.xml:system/etc/media_codecs_8956.xml \
                      device/qcom/msm8952_32/media/media_codecs_performance_8952.xml:system/etc/media_codecs_performance.xml \
                      device/qcom/msm8952_32/media/media_codecs_performance_8956.xml:system/etc/media_codecs_performance_8956.xml \
                      device/qcom/msm8952_32/media/media_codecs_8956_v1.xml:system/etc/media_codecs_8956_v1.xml \
                      device/qcom/msm8952_32/media/media_codecs_performance_8956_v1.xml:system/etc/media_codecs_performance_8956_v1.xml
endif

PRODUCT_COPY_FILES += device/qcom/msm8952_32/whitelistedapps.xml:system/etc/whitelistedapps.xml

PRODUCT_PROPERTY_OVERRIDES += \
       dalvik.vm.heapminfree=6m \
       dalvik.vm.heapstartsize=14m
$(call inherit-product, frameworks/native/build/phone-xhdpi-2048-dalvik-heap.mk)
$(call inherit-product, device/qcom/common/common.mk)

PRODUCT_NAME := msm8952_32
PRODUCT_DEVICE := msm8952_32

# When can normal compile this module,  need module owner enable below commands
# font rendering engine feature switch
-include $(QCPATH)/common/config/rendering-engine.mk
ifneq (,$(strip $(wildcard $(PRODUCT_RENDERING_ENGINE_REVLIB))))
   MULTI_LANG_ENGINE := REVERIE
#   MULTI_LANG_ZAWGYI := REVERIE
endif

# telephony-ext jar is needed for MSIM manual provisioning and for other
# telephony related functionalities to work.
PRODUCT_BOOT_JARS += vcard \
                     tcmiface \
                     telephony-ext
PRODUCT_BOOT_JARS += qcmediaplayer

PRODUCT_PACKAGES += telephony-ext
ifneq ($(strip $(QCPATH)),)
    PRODUCT_BOOT_JARS += qcom.fmradio
    PRODUCT_BOOT_JARS += WfdCommon
#Android oem shutdown hook
    PRODUCT_BOOT_JARS += oem-services
#    PRODUCT_BOOT_JARS += com.qti.dpmframework
#    PRODUCT_BOOT_JARS += dpmapi
#    PRODUCT_BOOT_JARS += com.qti.location.sdk
endif

# Audio configuration file
-include $(TOPDIR)hardware/qcom/audio/configs/msm8952_32/msm8952_32.mk

# ANT+ stack
PRODUCT_PACKAGES += \
    AntHalService \
    libantradio \
    antradio_app

# Feature definition files for msm8952
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:system/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:system/etc/permissions/android.hardware.sensor.stepdetector.xml

# MIDI feature
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.midi.xml:system/etc/permissions/android.software.midi.xml

#fstab.qcom
PRODUCT_PACKAGES += fstab.qcom

#OEM Services library
PRODUCT_PACKAGES += oem-services
PRODUCT_PACKAGES += libsubsystem_control
PRODUCT_PACKAGES += libSubSystemShutdown

PRODUCT_PACKAGES += wcnss_service

# MSM IRQ Balancer configuration file
PRODUCT_COPY_FILES += \
    device/qcom/msm8952_32/msm_irqbalance.conf:system/vendor/etc/msm_irqbalance.conf \
    device/qcom/msm8952_32/msm_irqbalance_little_big.conf:system/vendor/etc/msm_irqbalance_little_big.conf

#wlan driver
PRODUCT_COPY_FILES += \
    device/qcom/msm8952_32/WCNSS_qcom_cfg.ini:system/etc/wifi/WCNSS_qcom_cfg.ini \
    device/qcom/msm8952_32/WCNSS_qcom_wlan_nv.bin:persist/WCNSS_qcom_wlan_nv.bin \
    device/qcom/msm8952_32/WCNSS_wlan_dictionary.dat:persist/WCNSS_wlan_dictionary.dat


PRODUCT_PACKAGES += \
    wpa_supplicant_overlay.conf \
    p2p_supplicant_overlay.conf
#ANT+ stack
PRODUCT_PACKAGES += \
AntHalService \
libantradio \
antradio_app

# Defined the locales
PRODUCT_LOCALES += th_TH vi_VN tl_PH hi_IN ar_EG ru_RU tr_TR pt_BR bn_IN mr_IN ta_IN te_IN zh_HK \
        in_ID my_MM km_KH sw_KE uk_UA pl_PL sr_RS sl_SI fa_IR kn_IN ml_IN ur_IN gu_IN or_IN zh_CN

# When can normal compile this module, need module owner enable below commands
# Add the overlay path
PRODUCT_PACKAGE_OVERLAYS := $(QCPATH)/qrdplus/Extension/res \
        $(QCPATH)/qrdplus/globalization/multi-language/res-overlay \
        $(PRODUCT_PACKAGE_OVERLAYS)

# Sensor HAL conf file
PRODUCT_COPY_FILES += \
     device/qcom/msm8952_32/sensors/hals.conf:system/etc/sensors/hals.conf

PRODUCT_SUPPORTS_VERITY := true
PRODUCT_SYSTEM_VERITY_PARTITION := /dev/block/bootdevice/by-name/system

#for android_filesystem_config.h
PRODUCT_PACKAGES += \
    fs_config_files
