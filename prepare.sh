#!/bin/bash
set -x

SCRIPTPATH="$(dirname "$(readlink -e "$0")" )"

CORES=$(nproc)

ln -s ${SCRIPTPATH} ${SCRIPTPATH}/gluon/site
cd gluon
TARGETS="$(make list-targets)"
make update
for TARGET in ${TARGETS}; do
    make -j$((CORES+1)) GLUON_TARGET=${TARGET} download
done
