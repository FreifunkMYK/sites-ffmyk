#!/bin/bash
set -x

SCRIPTPATH="$(dirname "$(readlink -e "$0")" )"

TARGETS="ar71xx-generic ar71xx-nand ar71xx-tiny ath79-generic brcm2708-bcm2708 brcm2708-bcm2709 ipq40xx-generic ipq806x-generic lantiq-xrx200 lantiq-xway mpc85xx-generic mpc85xx-p1020 ramips-mt7620 ramips-mt7621 ramips-mt76x8 ramips-rt305x sunxi-cortexa7 x86-generic x86-geode x86-64"

CORES=$(nproc)
MAKEOPTS="-j$((CORES+1))"

RELEASE=$1

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
        rm -f site
        rm -rf output
        exit 1;
    fi
done
make GLUON_BRANCH=stable GLUON_RELEASE=${RELEASE} manifest
mv output/images/sysupgrade/stable.manifest ${SCRIPTPATH}/output/$RELEASE/stable.manifest
mv output/packages/* ${SCRIPTPATH}/output/$RELEASE/packages/
mv output/images ${SCRIPTPATH}/output/$RELEASE/
for TARGET in ${TARGETS}; do
    make clean GLUON_TARGET=${TARGET}
done
rm -f site
cd ..
