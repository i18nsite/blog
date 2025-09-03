#!/bin/bash

# 脚本功能：连接到指定的安卓盒子并安装apk目录下的所有apk文件
# 用法: ./apk_install.sh <安卓盒子IP地址>

if [ -z "$1" ]; then
  echo "错误：请输入安卓盒子的IP地址"
  echo "用法: $0 <安卓盒子IP地址>"
  exit 1
fi

set -ex

BOX_IP="$1"

echo "正在连接到 $BOX_IP..."
adb connect $BOX_IP
adb root

echo "连接成功！"

for apk_file in apk/*.apk; do
  if [ -f "$apk_file" ]; then
    adb install -r "$apk_file"
  fi
done

echo "所有APK安装完毕！"
