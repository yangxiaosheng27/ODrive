FROM ubuntu:22.04

SHELL ["/bin/bash", "-c"]

RUN set -x && \
    sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list && \
    sed -i 's/security.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list && \
    apt-get update

# 配置ssh
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
COPY id_rsa.pub /root/.ssh/authorized_keys
RUN chmod 700 /root/.ssh && chmod 600 /root/.ssh/authorized_keys
EXPOSE 22

# 配置开发环境
RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install gcc-arm-none-eabi
RUN apt-get -y install openocd
RUN apt-get -y install build-essential
RUN apt-get -y install cmake

# 指定路径
RUN mkdir -p /ODrive && mkdir -p /ODrive/Firmware
WORKDIR /ODrive/Firmware

# 使用 ENTRYPOINT 启动 SSH 并切换
ENTRYPOINT ["/bin/sh", "-c", "/usr/sbin/sshd -D & cd /ODrive/Firmware && exec bash"]
