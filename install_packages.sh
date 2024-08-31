#!/bin/bash

# 设置包列表文件路径
PKG_LIST="pkglist.txt"

# 确保包列表文件存在
if [[ ! -f "$PKG_LIST" ]]; then
    echo "包列表文件 $PKG_LIST 不存在。请确保文件在脚本的同一目录下。"
    exit 1
fi

# 更新系统
echo "更新系统..."
sudo pacman -Syu --noconfirm

# 读取包列表并安装包
echo "安装包..."
while read -r package; do
    if pacman -Qi "$package" &>/dev/null; then
        echo "$package 已经安装，跳过..."
    else
		echo "安装 $package ..."
        sudo pacman -S --noconfirm "$package"
    fi
done < "$PKG_LIST"

echo "所有包已安装完成。"
