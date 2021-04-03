#!/bin/bash

ROOTDIR=${HOME}/apps/geant4
APPDIR=${ROOTDIR}/apps
INSTALLDIR=${ROOTDIR}/install

cd ${APPDIR}/basic/ex_${IND}/B${IND}_build
cmake -DGeant4_DIR=${INSTALLDIR}/lib/Geant4-10.7.1/ ${APPDIR}/basic/ex_${IND}/B${IND} \
|& tee >(ts "[%x %X]" > ${APPDIR}/basic/ex_${IND}/B${IND}_build/c.log)
make -j4 B_${IND} |& tee >(ts "[%x %X]" > ${APPDIR}/basic/ex_${IND}/B${IND}_build/m.log)