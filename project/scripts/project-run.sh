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

cd ${PROJDIR}/NEBULA_build

${PROJDIR}/NEBULA_build/${PROJNAME} ${PROJDIR}/NEBULA_build/run1.mac

cd ${PROJDIR}
