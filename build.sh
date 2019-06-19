#!/bin/bash -x

SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE}[0]) && pwd)
source ${SCRIPT_DIR}/admin/devenv.sh $@

# debug/release
CMAKE_BUILD_TYPE="Debug"
if [[ ${BUILD_TYPE} == "release" ]] ; then
   CMAKE_BUILD_TYPE="RelWithDebInfo"
fi

# set install location
INSTALL_PREFIX="${INSTALL_BASE}/${PROJECT_NAME}/${PROJECT_VERSION}${SUFFIX}/${BUILD_TYPE}"

# delete old install
[[ -n ${INSTALL_PREFIX} && -d ${INSTALL_PREFIX} ]] && rm -rf ${INSTALL_PREFIX}

# delete old build
rm -rf build
mkdir build
cd build

# do the build
cmake  \
   ${GOOGLE_TEST} \
   -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
   -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX} -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} \
   -DMAMA_SRC=${OPENMAMA_SOURCE} -DMAMA_ROOT=${OPENMAMA_INSTALL} \
   ..
make ${VERBOSE} && make ${VERBOSE} install
rc=$?
[[ $rc -ne 0 ]] && exit $rc

# copy source to facilitate debugging
mkdir -p ${INSTALL_PREFIX}/src
cp -rp ../src ${INSTALL_PREFIX}/
