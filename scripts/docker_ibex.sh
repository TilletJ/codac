#!/bin/bash

mkdir -p /io/cache
cd /io/cache
if [ ! -d "/io/cache/ibex-lib" ]; then
  git clone -b develop https://github.com/ibex-team/ibex-lib.git
  cd ibex-lib
  git checkout 47fc75a5e14eb2f353ae7e0b37ac0f9dad7801c0
  mkdir build && cd build
  cmake -DCMAKE_CXX_FLAGS="-fPIC" -DCMAKE_C_FLAGS="-fPIC" -DCMAKE_INSTALL_PREFIX=/io/cache/ibex-lib/build_install ..
  make
  make install
else
  cd /io/cache/ibex-lib
  make install
fi