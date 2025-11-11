#!/bin/bash

# 修改默认IP
sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate

# 更改默认 Shell 为 zsh
# sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' package/base-files/files/etc/passwd

# TTYD 免登录
sed -i 's|/bin/login|/bin/login -f root|g' feeds/packages/utils/ttyd/files/ttyd.config


# 添加额外插件
git clone https://github.com/animegasan/luci-app-wolplus package/luci-app-wolplus

git clone  https://github.com/gdy666/luci-app-lucky.git package/lucky

./scripts/feeds update -a
./scripts/feeds install -a

# --- 以下是新增的修复命令 ---

# 修复 double-conversion 的 CMake 兼容性问题
# 使用 sed 命令查找并替换 CMakeLists.txt 中的 minimum_required 版本要求为 3.5
echo "Applying fix for double-conversion CMake incompatibility..."
find feeds/packages/libs/libdouble-conversion -name CMakeLists.txt -exec sed -i 's/cmake_minimum_required(VERSION .*)/cmake_minimum_required(VERSION 3.5)/g' {} +
echo "Fix applied."
