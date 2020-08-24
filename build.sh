#!/bin/bash
set -x

SCRIPTPATH="$(dirname "$(readlink -e "$0")" )"

CORES=$(nproc)

RELEASE=$1

rm -rf $SCRIPTPATH/output/$RELEASE
mkdir -p $SCRIPTPATH/output/$RELEASE/packages

ln -s ${SCRIPTPATH} ${SCRIPTPATH}/gluon/site
cd gluon
TARGETS="$(make list-targets)"
for patch in ${SCRIPTPATH}/patches/*.patch; do
    git apply $patch
done
make update
for TARGET in ${TARGETS}; do
    echo ${TARGET}
    make -j$((CORES+1)) GLUON_TARGET=${TARGET} GLUON_RELEASE=${RELEASE} GLUON_BRANCH=stable
    RESULT=$?
    if [ $RESULT -ne 0 ]; then
        echo $TARGET failed;
        make GLUON_TARGET=${TARGET} GLUON_RELEASE=${RELEASE} GLUON_BRANCH=stable V=s
        RESULT=$?
        if [ $RESULT -ne 0 ]; then
            echo $TARGET failed again;
            rm -rf output
            for TARGET in ${TARGETS}; do
                make clean GLUON_TARGET=${TARGET}
            done
            rm -f site
            exit 1;
        fi
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
