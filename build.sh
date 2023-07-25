#!/bin/bash
set -x

SCRIPTPATH="$(dirname "$(readlink -e "$0")" )"

CORES=$(nproc)

RELEASE=$1

TARGETS=$2

rm -rf $SCRIPTPATH/output/$RELEASE
mkdir -p $SCRIPTPATH/output/$RELEASE/packages

if [ ! -h ${SCRIPTPATH}/gluon/site ]; then
	ln -s ${SCRIPTPATH} ${SCRIPTPATH}/gluon/site
fi

cd gluon
if [ -z "$TARGETS" ]; then
    TARGETS="$(make list-targets)"
fi

make update
for TARGET in ${TARGETS}; do
    make -j$((CORES+1)) GLUON_TARGET=${TARGET} download
done

FAILED_TARGETS=
for TARGET in ${TARGETS}; do
    echo ${TARGET}
    make -j$((CORES+1)) GLUON_TARGET=${TARGET} GLUON_RELEASE=${RELEASE} GLUON_AUTOUPDATER_BRANCH=stable
    RESULT=$?
    if [ $RESULT -ne 0 ]; then
        echo $TARGET failed;
	FAILED_TARGETS="$FAILED_TARGETS $TARGET"
    fi
done

for TARGET in $FAILED_TARGETS; do
    make -j1 GLUON_TARGET=${TARGET} GLUON_RELEASE=${RELEASE} GLUON_AUTOUPDATER_BRANCH=stable V=s
    RESULT=$?
    if [ $RESULT -ne 0 ]; then
        make clean GLUON_TARGET=${TARGET}
        echo $TARGET failed again;
        echo "FAILED_TARGETS: $FAILED_TARGETS"
        exit 1;
    fi
done

make GLUON_AUTOUPDATER_BRANCH=stable GLUON_RELEASE=${RELEASE} manifest
mv output/images/sysupgrade/stable.manifest ${SCRIPTPATH}/output/$RELEASE/stable.manifest
mv output/packages/* ${SCRIPTPATH}/output/$RELEASE/packages/
mv output/images ${SCRIPTPATH}/output/$RELEASE/
for TARGET in ${TARGETS}; do
    make clean GLUON_TARGET=${TARGET}
done
cd ..
