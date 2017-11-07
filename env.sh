#!/bin/bash

# Verbose output or clean output
export VERBOSE=0
export OUTPUT_FILE="$(pwd)/logs/$(date +%Y%m%d-%H%M)_gm.log"

# List of architectures to build
# export ARCHS="armv7 armv7s arm64 i386 x86_64"
export ARCHS="arm64 x86_64"

# Get number of cores to speed up make (make -j$CORESNUM)
export CORESNUM=`sysctl hw.ncpu | awk '{print $2}'`

# Check that the SDK exports can be made
if [ ! -d $DEVROOT ]; then
	echo "Unable to find the XCode"
	echo "The path is automatically set from 'xcode-select -print-path'"
	echo
	echo "Ensure that 'xcode-select -print-path' works (e.g., Install XCode)"
	exit 1
fi

# iOS SDK Environmnent
export SDKVER=`xcodebuild -showsdks | fgrep "iphoneos" | tail -n 1 | awk '{print $2}'`
export DEVROOT=`xcode-select -print-path`/Platforms/iPhoneOS.platform/Developer
export IOSSDKROOT=$DEVROOT/SDKs/iPhoneOS$SDKVER.sdk

# iPhoneSimulator SDK Environment
export SIMSDKVER=`xcodebuild -showsdks | fgrep "iphonesimulator" | tail -n 1 | awk '{print $4}'`
export SIMDEVROOT=`xcode-select -print-path`/Platforms/iPhoneSimulator.platform/Developer
export SIMSDKROOT=$SIMDEVROOT/SDKs/iPhoneSimulator$SIMSDKVER.sdk

# Xcode doesn't include /usr/local/bin
# export PATH="$PATH":/usr/local/bin

# Source directories
export GMROOT="$(pwd)"
export BUILDROOT="$GMROOT/src"
export GM_DIR="$BUILDROOT/GraphicsMagick-$GM_VERSION"
export GM_DELEGATES_DIR="$BUILDROOT/GMDelegates/"
export JPEG_DIR="$BUILDROOT/GMDelegates/jpeg-9b"
export PNG_DIR="$BUILDROOT/GMDelegates/libpng-1.6.34"
export TIFF_DIR="$BUILDROOT/GMDelegates/tiff-4.0.8"

# Target directories
export TARGET_LIB_DIR=$(pwd)/target
export JPEG_LIB_DIR=$TARGET_LIB_DIR/libjpeg
export PNG_LIB_DIR=$TARGET_LIB_DIR/libpng
export TIFF_LIB_DIR=$TARGET_LIB_DIR/libtiff
export GM_LIB_DIR=$TARGET_LIB_DIR/graphicsmagick
export LIB_DIR=$TARGET_LIB_DIR/libs

# Target directory to import in XCode project
export FINAL_DIR=$(pwd)/GMPORT_ME
