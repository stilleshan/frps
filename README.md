# frps
## 项目简介
基于 [fatedier/frp](https://github.com/fatedier/frp) 原版 frp 内网穿透服务端 frps 的一键安装卸载脚本和 docker 镜像.支持 Linux 服务器和 docker 等多种环境安装部署.

- GitHub [stilleshan/frps](https://github.com/stilleshan/frps)
- Docker [stilleshan/frps](https://hub.docker.com/r/stilleshan/frps)
> *docker image support for X86 and ARM*

## 更新
- **2024-02-25** 更新到新版本,支持 toml 配置文件.
- **2021-05-31** 更新国内镜像方便使用
- **2021-05-31** 更新 Linux 一键安装脚本同时支持 X86 和 ARM
- **2021-05-29** 更新从`0.36.2`版本起 docker 镜像同时支持 X86 和 ARM

## 使用
由于 frps 服务端需要配置参数,本脚本为原版 frps.toml ,安装完毕后请自行编辑 frps.toml 配置端口,密码等相关参数并重启服务.同时你也可以 fork 本仓库后自行修改 frps.toml ,在进行一键安装也非常方便.后期也可自行配置 frps.toml 和调整 frps 的版本.

### 一键脚本(先执行脚本,在自行修改 frps.toml 文件.)
安装
```shell
wget https://raw.githubusercontent.com/stilleshan/frps/master/frps_linux_install.sh && chmod +x frps_linux_install.sh && ./frps_linux_install.sh
# 以下为国内镜像
wget https://github.ioiox.com/stilleshan/frps/raw/branch/master/frps_linux_install.sh && chmod +x frps_linux_install.sh && ./frps_linux_install.sh
```

使用
```shell
vi /usr/local/frp/frps.toml
# 修改 frps.toml 配置
sudo systemctl restart frps
# 重启 frps 服务即可生效
```

卸载
```shell
wget https://raw.githubusercontent.com/stilleshan/frps/master/frps_linux_uninstall.sh && chmod +x frps_linux_uninstall.sh && ./frps_linux_uninstall.sh
# 以下为国内镜像
wget https://github.ioiox.com/stilleshan/frps/raw/branch/master/frps_linux_uninstall.sh && chmod +x frps_linux_uninstall.sh && ./frps_linux_uninstall.sh
```

### 自定义一键脚本(先 fork 本仓库,在自行修改 frps.toml 文件后执行脚本.)
- 首先 fork 本仓库
- 配置 frps.toml
- 修改 frps_linux_install.sh 脚本
- 修改脚本链接
- Push 仓库到 GitHub

#### 修改 frps_linux_install.sh 脚本
`FRP_VERSION=0.58.0` 可根据原版项目更新自行修改为最新版本.  
`REPO=stilleshan/frps` 由于 **fork** 到你自己的仓库,需修改`stilleshan`为你的 GitHub 账号ID.

#### 执行一键脚本
修改以下脚本链接中的`stilleshan`为你的 GitHub 账号 ID 后,执行即可.
```shell
wget https://raw.githubusercontent.com/stilleshan/frps/master/frps_linux_install.sh && chmod +x frps_linux_install.sh && ./frps_linux_install.sh
```
#### 卸载脚本
frps_linux_uninstall.sh 卸载脚本为通用脚本,可直接执行,也可同上方式修改链接后执行.
```shell
wget https://raw.githubusercontent.com/stilleshan/frps/master/frps_linux_uninstall.sh && chmod +x frps_linux_uninstall.sh && ./frps_linux_uninstall.sh
```

### frps相关命令
```shell
sudo systemctl start frps
# 启动服务 
sudo systemctl enable frps
# 开机自启
sudo systemctl status frps
# 状态查询
sudo systemctl restart frps
# 重启服务
sudo systemctl stop frps
# 停止服务
```

### docker 部署
为避免因 **frps.toml** 文件的挂载,格式或者配置的错误导致容器无法正常运行并循环重启.请确保先配置好 **frps.toml** 后在执行启动.

先 **git clone** 本仓库,并正确配置 **frps.toml** 文件.
```shell
git clone https://github.com/stilleshan/frps
# git clone 本仓库
git clone https://github.ioiox.com/stilleshan/frps
# 国内镜像
vi /root/frps/frps.toml
# 配置 frps.toml 文件
```
启动容器
```shell
docker run -d --name=frps --restart=always \
    --network host \
    -v /root/frps/frps.toml:/frp/frps.toml  \
    stilleshan/frps
```
> 以上命令 -v 挂载的目录是以 git clone 本仓库为例,也可以在任意位置手动创建 frps.toml 文件,并修改命令中的挂载路径.

服务运行中修改 **frps.toml** 配置后需重启 **frps** 服务.
```shell
vi /root/frps/frps.toml
# 修改 frps.toml 配置
docker restart frps
# 重启 frps 容器即可生效
```

## 链接
- Blog [www.ioiox.com](https://www.ioiox.com)
- GitHub [stilleshan/frps](https://github.com/stilleshan/frps)
- Docker Hub [stilleshan/frps](https://hub.docker.com/r/stilleshan/frps)
- Docker [docker.ioiox.com](https://docker.ioiox.com)
- 原版frp项目 [fatedier/frp](https://github.com/fatedier/frp)
- [CentOS 7 安装配置frp内网穿透服务器端教程](https://www.ioiox.com/archives/5.html)