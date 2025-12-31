#!/bin/sh

set -e

# 进入脚本所在目录
cd "$(dirname -- "$0")"
export THEOS=/Users/zqbb/theos_roothide
# export DEVELOPER_DIR="/Applications/Xcode-14.3.0.app/Contents/Developer"

PREV_DIR=$(pwd)
WORK_DIR=$(dirname -- "$0")
cd "$WORK_DIR"

cd basebin
./build.sh
cd -

rm -rf Bootstrap/basebin
cp -a basebin/.build Bootstrap/basebin

make clean
make package

cd "$PREV_DIR"
