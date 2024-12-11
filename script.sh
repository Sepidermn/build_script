#!/bin/bash

# Remove the local manifests directory if it exists (cleanup before repo initialization)
rm -rf .repo/local_manifests/

# remove device tree
rm -rf device/xiaomi/mojito
rm -rf device/xiaomi/sm6150-common
rm -rf kernel/xiaomi/mojito
rm -rf vendor/xiaomi/sm6150-common
rm -rf hardware/xiaomi

# Initialize ROM manifest
repo init -u https://github.com/2by2-Project/android.git -b 15 --git-lfs

# Sync the repo with force to ensure a clean sync
/opt/crave/resync.sh

# remove frameworks/av
rm -rf frameworks/av
# remove frameworks/base
rm -rf frameworks/base

# cloning device tree
git clone https://github.com/Sepidermn/android_device_xiaomi_mojito.git --depth 1 -b 2by2 device/xiaomi/mojito
git clone https://github.com/Sepidermn/android_device_xiaomi_sm6150-common.git --depth 1 -b ros device/xiaomi/sm6150-common

# cloning kernel tree
git clone https://github.com/Sepidermn/android_kernel_xiaomi_mojito.git --depth 1 -b 2by2 kernel/xiaomi/mojito

# cloning vendor tree
git clone https://gitlab.com/Sepidermn/android_vendor_xiaomi_mojito.git --depth 1 -b 15 vendor/xiaomi/mojito
git clone https://gitlab.com/Sepidermn/android_vendor_xiaomi_sm6150-common.git --depth 1 -b 15 vendor/xiaomi/sm6150-common

# cloning hardware tree
git clone https://github.com/Sepidermn/android_hardware_xiaomi.git --depth 1 -b mojito hardware/xiaomi

# add mood 
git clone https://github.com/Sepidermn/android_frameworks_av.git --depth 1 -b 14 frameworks/av
git clone https://github.com/Sepidermn/android_frameworks_base.git --depth 1 -b 15 frameworks/base

# Set up th build environment
. build/envsetup.sh

# Choose the target device
brunch mojito userdebug
