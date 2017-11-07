#!/bin/bash

if [[ $# != 1 ]]; then
	echo "$0 takes 1 argument: the version of GraphicsMagick you want to compile!"
	echo "EXAMPLE: $0 1.3.26"
	exit
fi

export GM_VERSION="$1"

# Configuration / Function scripts
. $(dirname $0)/env.sh   # environment variables
. $(dirname $0)/flags.sh # compiler flags
. $(dirname $0)/utils.sh # various functions

# Compilation scripts
. $(dirname $0)/compile_png.sh  # libPNG
. $(dirname $0)/compile_jpeg.sh # JPEG
. $(dirname $0)/compile_tiff.sh # TIFF
. $(dirname $0)/compile_graphicsmagick.sh   # ImageMagick

# --- CLEAN IS SPECIAL --- #
if [[ $1 == "clean" ]]; then
	echo "Cleaning..."
	rm *.log 2>/dev/null
	rm -r ${TARGET_LIB_DIR}/ 2>/dev/null
	rm -r ${FINAL_DIR}/ 2>/dev/null
	echo "Done!"
	exit 0
fi

# --- ZIP IS SPECIAL --- #
# Used by Claudio Marforio to generate zips for the graphicsmagick FTP
if [[ $1 == "zip" ]]; then
	zip_for_ftp
	exit 0
fi

# --- WHAT GETS EXECUTED --- #
prepare

for i in $ARCHS; do
	png $i
	jpeg $i
	tiff $i
	gm $i
done

structure_for_xcode
