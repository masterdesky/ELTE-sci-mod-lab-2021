#!/bin/bash

PROJNAME="project_nebula"
PROJDIR="/home/masterdesky/GitHub/ELTE_Modelling_Lab_2021/project/project_nebula"
GEANT4INSTALL="/home/masterdesky/apps/Geant4/install"

# Source Geant4
if [ -f ${GEANT4INSTALL}/bin/geant4.sh ];
then
    cd ${GEANT4INSTALL}/bin/
    source geant4.sh
    cd ~-
fi

cd ${PROJDIR}/NEBULA_build

PHYSICS_LIST=('QBBC' 'QGSP_BERT_HP' 'QGSP_BIC_HP' 'QGSP_INCLXX' 'QGSP_INCLXX_HP')
for PHYS in "${PHYSICS_LIST[@]}"
do
  ${PROJDIR}/NEBULA_build/${PROJNAME} ${PHYS} ${PROJDIR}/NEBULA_build/run1.mac
  cp ${PROJDIR}/NEBULA_build/NEBULA* ${PROJDIR}/data/${PHYS}/
done
cd ${PROJDIR}
