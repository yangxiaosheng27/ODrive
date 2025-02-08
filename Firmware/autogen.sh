#! /bin/sh -e

set -x
rm -rf autogen .tup build
mkdir -p autogen
python ../tools/odrive/version.py --output autogen/version.c
python interface_generator_stub.py --definitions odrive-interface.yaml --template ../tools/enums_template.j2 --output ../tools/odrive/enums.py
python interface_generator_stub.py --definitions odrive-interface.yaml --template ../tools/arduino_enums_template.j2 --output ../Arduino/ODriveArduino/ODriveEnums.h
tup init
tup generate build.sh
