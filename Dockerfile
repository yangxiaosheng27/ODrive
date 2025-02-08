FROM ubuntu:bionic

RUN ln -sf /bin/bash /bin/sh

RUN set -x && \
    sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list && \
    sed -i 's/security.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get -y install software-properties-common && \
    add-apt-repository ppa:team-gcc-arm-embedded/ppa && \
    add-apt-repository ppa:jonathonf/tup && \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install gcc-arm-embedded openocd tup python3.7 python3-yaml python3-jinja2 python3-jsonschema build-essential git time && \
    ln -s /usr/bin/python3.7 /usr/bin/python && \
    mkdir -p ODrive && \
    git config --global --add safe.directory /ODrive

WORKDIR ODrive/Firmware

CMD ["/bin/bash"]