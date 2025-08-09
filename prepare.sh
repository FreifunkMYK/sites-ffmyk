#!/bin/bash
set -x

SCRIPTPATH="$(dirname "$(readlink -e "$0")" )"

if [ ! -h ${SCRIPTPATH}/gluon/site ]; then
	ln -s ${SCRIPTPATH} ${SCRIPTPATH}/gluon/site
fi

cd gluon
make update

TARGETS="$(make list-targets)"
for TARGET in ${TARGETS}; do
    make -j$((CORES+1)) GLUON_TARGET=${TARGET} download
done

for patch in ${SCRIPTPATH}/patches/*.patch; do
	git apply $patch
done
