#!/bin/bash

PROJNAME=
PROJDIR=
GEANT4INSTALL=

# Source Geant4
if [ -f ${GEANT4INSTALL}/bin/geant4.sh ];
then
    cd ${GEANT4INSTALL}/bin/
    source geant4.sh
    cd ~-
fi

cd ${PROJDIR}/B1_build
rm -rf ${PROJDIR}/B1_build/*
cmake -DGeant4_DIR=${GEANT4INSTALL}/lib/Geant4-10.7.1/ \
			${PROJDIR}/B1 \
			|& tee >(ts "[%x %X]" > ${PROJDIR}/B1_build/c.log)
make -j4 B1 |& tee >(ts "[%x %X]" > ${PROJDIR}/B1_build/m.log)