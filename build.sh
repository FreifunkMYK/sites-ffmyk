#!/bin/bash
set -x

SCRIPTPATH="$(dirname "$(readlink -e "$0")" )"

TARGETS="ar71xx-generic ar71xx-nand ar71xx-tiny brcm2708-bcm2708 brcm2708-bcm2709 mpc85xx-generic ramips-mt7621 sunxi x86-generic x86-geode x86-64"

CORES=$(nproc)
MAKEOPTS="-j$((CORES+1))"

AUTOUPDATER_PRIORITY=10

RELEASE=$1

if [ ! -z $2 ]; then
    TARGETS=$2
fi


rm -rf $SCRIPTPATH/output/$RELEASE
mkdir -p $SCRIPTPATH/output/$RELEASE/packages

ln -s ${SCRIPTPATH} ${SCRIPTPATH}/gluon/site
cd gluon
for patch in ${SCRIPTPATH}/patches/*.patch; do
    git apply $patch
done
make update
for TARGET in ${TARGETS}; do
    echo ${TARGET}
    make ${MAKEOPTS} GLUON_TARGET=${TARGET} GLUON_RELEASE=${RELEASE} GLUON_BRANCH=stable V=s
    RESULT=$?
    if [ $RESULT -ne 0 ]; then
        echo $TARGET failed;
        rm -f site output
        exit 1;
    fi
done
make GLUON_BRANCH=autoupdater GLUON_PRIORITY=${AUTOUPDATER_PRIORITY} GLUON_RELEASE=${RELEASE} manifest
make GLUON_BRANCH=stable GLUON_RELEASE=${RELEASE} manifest
mv output/images/sysupgrade/autoupdater.manifest ${SCRIPTPATH}/output/$RELEASE/autoupdater.manifest
mv output/images/sysupgrade/stable.manifest ${SCRIPTPATH}/output/$RELEASE/stable.manifest
mv output/packages/* ${SCRIPTPATH}/output/$RELEASE/packages/
mv output/images ${SCRIPTPATH}/output/$RELEASE/
for TARGET in ${TARGETS}; do
    make clean GLUON_TARGET=${TARGET}
done
rm -f site
cd ..
