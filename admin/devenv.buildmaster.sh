#!/bin/bash -x

#################################################################
# set environment specific to  CruiseControl build
#################################################################

# BUILD_TYPE is normally release for CC
export BUILD_TYPE=release
#export BUILD_TYPE=debug

# prevent annoying debug messages
unset MALLOC_CHECK_

# standard install location
export INSTALL_BASE=/build/share

# use "nyfix" gcc
export GCC_ROOT=/opt/nyfix/gcc/4.3.3
export CC=${GCC_ROOT}/bin/gcc
export CXX=${GCC_ROOT}/bin/g++

# cmake
export PATH=/build/share/cmake/${CMAKE_VERSION}/bin:$PATH

