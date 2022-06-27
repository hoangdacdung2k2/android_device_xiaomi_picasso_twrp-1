#
# Copyright (C) 2021 The OmniRom Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from common AOSP config
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)

# Installs gsi keys into ramdisk, to boot a GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

LOCAL_PATH := device/xiaomi/picasso

# Dynamic Partition
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    android.hardware.fastboot@1.0-impl-mock.recovery \
    fastbootd

# qcom decryption
PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe
# Additional binaries & libraries needed for recovery
TARGET_RECOVERY_DEVICE_MODULES += \
    libion \
    libxml2

TW_RECOVERY_ADDITIONAL_RELINK_LIBRARY_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libxml2.so

# Overrides
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=$(PRODUCT_RELEASE_NAME) \
    TARGET_DEVICE=$(PRODUCT_RELEASE_NAME)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.product.device=$(PRODUCT_RELEASE_NAME)
# SHIPPING API
PRODUCT_SHIPPING_API_LEVEL := 30
# VNDK API
PRODUCT_TARGET_VNDK_VERSION := 31

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Overrides
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=$(PRODUCT_RELEASE_NAME) \
    TARGET_DEVICE=$(PRODUCT_RELEASE_NAME)

PRODUCT_PROPERTY_OVERRIDES += \
    ro.product.device=$(PRODUCT_RELEASE_NAME)
