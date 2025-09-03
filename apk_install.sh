#!/bin/bash

# 脚本功能：连接到指定的安卓盒子并安装apk目录下的所有apk文件
# 用法: ./apk_install.sh <安卓盒子IP地址>

# 检查是否提供了IP地址参数
if [ -z "$1" ]; then
  echo "错误：请输入安卓盒子的IP地址"
  echo "用法: $0 <安卓盒子IP地址>"
  exit 1
fi

BOX_IP="$1"

# 连接到安卓盒子
echo "正在连接到 $BOX_IP..."
adb connect "$BOX_IP"

# 检查连接是否成功
# 注意：adb devices的输出可能需要一些时间来更新
sleep 2
if ! adb devices | grep -q "$BOX_IP"; then
  echo "错误：无法连接到安卓盒子 $BOX_IP"
  exit 1
fi

echo "连接成功！"

# 遍历apk目录下的所有.apk文件并安装
for apk_file in apk/*.apk; do
  # 检查文件是否存在
  if [ -f "$apk_file" ]; then
    echo "正在安装 $apk_file..."
    # 使用 -r 参数以允许覆盖安装
    adb install -r "$apk_file"
  fi
done

echo "所有APK安装完毕！"
