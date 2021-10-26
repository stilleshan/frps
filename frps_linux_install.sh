#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

# fonts color
Green="\033[32m"
Red="\033[31m"
Yellow="\033[33m"
GreenBG="\033[42;37m"
RedBG="\033[41;37m"
Font="\033[0m"
# fonts color

# variable
FRP_VERSION=0.38.0
REPO=stilleshan/frps
WORK_PATH=$(dirname $(readlink -f $0))
FRP_NAME=frps
FRP_PATH=/usr/local/frp

if [ $(uname -m) = "x86_64" ]; then
    export PLATFORM=amd64
else if [ $(uname -m) = "aarch64" ]; then
    export PLATFORM=arm64
fi
fi

FILE_NAME=frp_${FRP_VERSION}_linux_${PLATFORM}

# 判断是否安装 frps
if [ -f "/usr/local/frp/${FRP_NAME}" ] || [ -f "/usr/local/frp/${FRP_NAME}.ini" ] || [ -f "/lib/systemd/system/${FRP_NAME}.service" ];then
    echo -e "${Green}=========================================================================${Font}"
    echo -e "${RedBG}当前已退出脚本.${Font}"
    echo -e "${Green}检查到服务器已安装${Font} ${Red}${FRP_NAME}${Font}"
    echo -e "${Green}请手动确认和删除${Font} ${Red}/usr/local/frp/${Font} ${Green}目录下的${Font} ${Red}${FRP_NAME}${Font} ${Green}和${Font} ${Red}/${FRP_NAME}.ini${Font} ${Green}文件以及${Font} ${Red}/lib/systemd/system/${FRP_NAME}.service${Font} ${Green}文件,再次执行本脚本.${Font}"
    echo -e "${Green}参考命令如下:${Font}"
    echo -e "${Red}rm -rf /usr/local/frp/${FRP_NAME}${Font}"
    echo -e "${Red}rm -rf /usr/local/frp/${FRP_NAME}.ini${Font}"
    echo -e "${Red}rm -rf /lib/systemd/system/${FRP_NAME}.service${Font}"
    echo -e "${Green}=========================================================================${Font}"
    exit 2
fi

# 判断 frps 进程并 kill
while ! test -z "$(ps -A | grep -w ${FRP_NAME})"; do
    FRPSPID=$(ps -A | grep -w ${FRP_NAME} | awk 'NR==1 {print $1}')
    kill -9 $FRPSPID
done

mkdir -p ${FRP_PATH}
wget -P ${WORK_PATH} https://ghproxy.com/https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/${FILE_NAME}.tar.gz -O ${FILE_NAME}.tar.gz && \
tar -zxvf ${FILE_NAME}.tar.gz && \
mv ${FILE_NAME}/${FRP_NAME} ${FRP_PATH}

wget -P ${FRP_PATH} https://ghproxy.com/https://raw.githubusercontent.com/${REPO}/master/${FRP_NAME}.ini && \
wget -P /lib/systemd/system https://ghproxy.com/https://raw.githubusercontent.com/${REPO}/master/${FRP_NAME}.service && \

systemctl daemon-reload
sudo systemctl start ${FRP_NAME}
sudo systemctl enable ${FRP_NAME}
rm -rf ${WORK_PATH}/${FILE_NAME}.tar.gz ${WORK_PATH}/${FILE_NAME} ${FRP_NAME}_linux_install.sh

echo -e "${Green}====================================================================${Font}"
echo -e "${Green}安装成功,请先修改 ${FRP_NAME}.ini 文件,确保格式及配置正确无误!${Font}"
echo -e "${Red}vi /usr/local/frp/${FRP_NAME}.ini${Font}"
echo -e "${Green}修改完毕后执行以下命令重启服务:${Font}"
echo -e "${Red}sudo systemctl restart ${FRP_NAME}${Font}"
echo -e "${Green}====================================================================${Font}"
