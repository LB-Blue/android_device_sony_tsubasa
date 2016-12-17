#!/bin/bash

FP=$(cd ${0%/*} && pwd -P)
export VENDOR=$(basename $(dirname $FP))
export DEVICE=$(basename $FP)
export BOARDCONFIGVENDOR=true

mkdir system
sudo mount -o loop -t ext4 system.ext4 system

BASE=../../../vendor/$VENDOR/$DEVICE/proprietary
rm -rf $BASE/*

for FILE in `grep -v ^# proprietary-files.txt | grep -v ^$ | sort`
do
  # Split the file from the destination (format is "file[:destination]")
  OLDIFS=$IFS IFS=":" PARSING_ARRAY=($FILE) IFS=$OLDIFS
  FILE=${PARSING_ARRAY[0]}
  DEST=${PARSING_ARRAY[1]}
  if [ -z "$DEST" ]; then
    DEST=$FILE
  fi
  DIR=`dirname $DEST`
  if [ ! -d $BASE/$DIR ]; then
    mkdir -p $BASE/$DIR
  fi
  
  cp ./system/$FILE $BASE/$DEST
  # if file dot not exist try destination
  if [ "$?" != "0" ]; then
    cp ./system/$DEST $BASE/$DEST
  fi
done

../common/setup-makefiles.sh

bspatch $BASE/vendor/lib/libqc-opt.so $BASE/vendor/lib/libqc-opt.so libqc-opt.bs

sudo umount system
rm -rf system

func_wget() {
	FN=$1
	DR=$2
	URL=https://github.com/TheMuppets/proprietary_vendor_sony/raw/cm-13.0/blue-common/proprietary/vendor/lib/
	wget -O $BASE/vendor/lib/$DR$FN $URL$DR$FN
}

if [ ! -d $BASE/vendor/lib/egl ]; then
	mkdir -p $BASE/vendor/lib/egl
fi

func_wget eglsubAndroid.so egl/
func_wget libEGL_adreno.so egl/
func_wget libGLESv1_CM_adreno.so egl/
func_wget libGLESv2_adreno.so egl/
func_wget libGLESv2S3D_adreno.so egl/
func_wget libq3dtools_adreno.so egl/
func_wget libadreno_utils.so
func_wget libC2D2.so
func_wget libc2d2_a3xx.so
func_wget libc2d2_z180.so
func_wget libCB.so
func_wget libgsl.so
func_wget libllvm-a3xx.so
func_wget libllvm-arm.so
func_wget libOpenCL.so
func_wget libOpenVG.so
func_wget libsc-a2xx.so
func_wget libsc-a3xx.so
