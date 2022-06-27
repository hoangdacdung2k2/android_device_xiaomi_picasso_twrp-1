#
# Copyright (C) 2021 The OmniRom Project
#
# SPDX-License-Identifier: Apache-2.0
#
# Release name (automatically taken from this file's suffix)
PRODUCT_RELEASE_NAME := $(lastword $(subst /, ,$(lastword $(subst _, ,$(firstword $(subst ., ,$(MAKEFILE_LIST)))))))

# Custom vendor used in build tree (automatically taken from this file's prefix)
CUSTOM_VENDOR := $(lastword $(subst /, ,$(firstword $(subst _, ,$(firstword $(MAKEFILE_LIST))))))

# Inherit from those products. Most specific first.
$(call inherit-product-if-exists, $(SRC_TARGET_DIR)/product/embedded.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# Inherit from our custom product configuration
$(call inherit-product, vendor/$(CUSTOM_VENDOR)/config/common.mk)

# Build with minimal manifest
ALLOW_MISSING_DEPENDENCIES := true
# OEM Info (automatically taken from device tree path)
BOARD_VENDOR := $(or $(word 2,$(subst /, ,$(firstword $(MAKEFILE_LIST)))),$(value 2))
# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := $(PRODUCT_RELEASE_NAME)
PRODUCT_NAME := $(CUSTOM_VENDOR)_$(PRODUCT_RELEASE_NAME)
PRODUCT_BRAND := Redmi
PRODUCT_MODEL := Redmi K30 5G
PRODUCT_MANUFACTURER := $(BOARD_VENDOR)

# Inherit from hardware-specific part of the product configuration
$(call inherit-product, device/$(BOARD_VENDOR)/$(PRODUCT_DEVICE)/device.mk)