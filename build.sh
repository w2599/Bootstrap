#!/bin/sh

set -e

PREV_DIR=$(pwd)
WORK_DIR=$(dirname -- "$0")
cd "$WORK_DIR"

cd basebin
./build.sh
cd -

rm -rf Bootstrap/basebin
cp -a basebin/.build Bootstrap/basebin

## 替换编译时间
TS=$(date +"%Y/%m/%d %H:%M:%S" | sed 's/^20//')
awk -v ts="$TS" '
/build-time/ {
    gsub(/@"[0-9][0-9]\/[0-9][0-9]\/[0-9][0-9] [0-9][0-9]:[0-9][0-9]:[0-9][0-9]"/, "@\"" ts "\"")
}
{ print }
' Bootstrap/ViewController.m > /tmp/tmp_vc.m && mv /tmp/tmp_vc.m Bootstrap/ViewController.m

make clean
make package

cd "$PREV_DIR"
