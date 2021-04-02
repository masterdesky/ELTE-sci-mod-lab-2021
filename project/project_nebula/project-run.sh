#!/bin/bash

PROJNAME="project_nebula"
PROJDIR=/home/masterdesky/GitHub/ELTE_Modelling_Lab_2021/project/${PROJNAME}
GEANT4INSTALL=/home/masterdesky/apps/Geant4/install

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
