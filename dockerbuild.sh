#!/usr/bin/env bash

script_path=$(realpath "$0")
script_dir=$(dirname "$script_path")

function cleanup {
    echo "Removing previous build artifacts"
    rm -rf build/ Firmware/autogen Firmware/build Firmware/.tup
    docker rm odrive-build-cont
}

function gc {
    cleanup
    docker rmi odrive-build-img
    docker image prune
}

function build {
    cleanup

    echo "Building the build-environment image"
    docker build -t odrive-build-img $script_dir

    echo "Build in container"
    docker run -it -v $script_dir:/ODrive --name odrive-build-cont odrive-build-img:latest 
}

function usage {
    echo "usage: $0 (build | cleanup | gc)"
    echo
    echo "build   -- build in docker and extract the artifacts."
    echo "cleanup -- remove build artifacts from previous build"
    echo "gc      -- remove all build images and containers"
}

case $1 in
    build)
	build
	;;
    cleanup)
	cleanup
	;;
    gc)
	gc
	;;
    *)
	usage
	;;
esac
