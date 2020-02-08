#!/bin/sh
# 停止frps
sudo systemctl stop frps && \
# 删除frps
rm -rf /usr/local/frp && \
# 删除frps.service
rm -rf /lib/systemd/system/frps.service && \
sudo systemctl daemon-reload && \
# 删除本文件
rm -rf frps_linux_uninstall.sh
echo "============================" &&\
echo -e "\033[32m卸载成功,相关文件已清理完毕!\033[0m" && \
echo "============================"