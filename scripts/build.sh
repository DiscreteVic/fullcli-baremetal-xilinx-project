#!/bin/bash

cd ../project

if [ ! -d build ]; then
    mkdir build
fi

cd build

cmake .. \
    && make