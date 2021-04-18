#!/bin/bash
set -x

SCRIPTPATH="$(dirname "$(readlink -e "$0")" )"

ln -s ${SCRIPTPATH} ${SCRIPTPATH}/gluon/site
cd gluon
for patch in ${SCRIPTPATH}/patches/*.patch; do
    git apply $patch
done
make update
make download
