#!/usr/bin/env bash

#script_path=$(realpath "$0")
#script_dir=$(dirname "$script_path")

function clean {
    #rm -rf build/ Firmware/build Firmware/.tup
    docker rm odrive-yxs
    docker rmi odrive-yxs-img
    #docker image prune
}

function build {
    clean

    echo "Building the build-environment image"
    docker build -t odrive-yxs-img .
}

function run {
    echo "Run the container"
    docker run -it -v .:/ODrive --name odrive-yxs -p 2222:22 odrive-yxs-img:latest
}

function help {
    echo "usage: $0 (build | run | rm | clean)"
    echo
    echo "clean     -- remove build artifacts, all build images and containers"
    echo "build     -- build in docker and extract the artifacts."
    echo "run       -- run the container."
}

case $1 in
    clean)
    clean
    ;;
    build)
    build
    ;;
    run)
    run
    ;;
    *)
    help
    ;;
esac
