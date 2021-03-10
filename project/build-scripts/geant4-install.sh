#!/bin/bash

ROOTDIR="/home/masterdesky/apps/geant4"
mkdir -p ${ROOTDIR}/apps ${ROOTDIR}/build ${ROOTDIR}/install

APPDIR=${ROOTDIR}/apps
BUILDDIR=${ROOTDIR}/build
INSTALLDIR=${ROOTDIR}/install
SRCDIR=${ROOTDIR}/geant4.10.07.p01/

# Downloading Geant4
echo
echo "Downloading Geant4..."
echo

if [ ! -d ${SRCDIR} ]; then
    wget http://geant4-data.web.cern.ch/geant4-data/releases/source/geant4.10.07.p01.tar.gz -P ${ROOTDIR}
    tar -xzvf ${ROOTDIR}/geant4.10.07.p01.tar.gz -C ${ROOTDIR}
    rm -f ${ROOTDIR}/geant4.10.07.p01.tar.gz
fi

# Installing Geant4
echo
echo "Installing Geant4..."
echo

cd ${BUILDDIR}
if [ -f ${BUILDDIR}/mi.log ]; then
	make uninstall |& tee >(ts "[%x %X]" > ${BUILDDIR}/mu.log)
	make clean |& tee >(ts "[%x %X]" > ${BUILDDIR}/cl.log)
fi
cmake \
-DCMAKE_INSTALL_PREFIX=${INSTALLDIR} \
-DCMAKE_PREFIX_PATH="/usr/lib/x86_64-linux-gnu/" \
-DGEANT4_INSTALL_DATA=ON \
-DGEANT4_INSTALL_DATADIR=${INSTALLDIR}/share/Geant4-10.07.p01/data/ \
-DGEANT4_USE_OPENGL_X11=ON \
-DGEANT4_USE_QT=ON  \
-DGEANT4_USE_GDML=ON -DGEANT4_BUILD_MULTITHREADED=ON ${SRCDIR} \
|& tee >(ts "[%x %X]" > ${BUILDDIR}/c.log)
make -j4 VERBOSE=1 |& tee >(ts "[%x %X]" > ${BUILDDIR}/m.log)
make install |& tee >(ts "[%x %X]" > ${BUILDDIR}/mi.log)
cd ${ROOTDIR}

# Setup test examples
cp -r ${SRCDIR}/examples/basic ${APPDIR}/
cp -r ${SRCDIR}/examples/advanced ${APPDIR}/
cp -r ${SRCDIR}/examples/extended ${APPDIR}/

for IND in 1 2 3 4 5
do
	echo
	echo "Preparing basic example B${IND}"
	echo
	mkdir -p ${APPDIR}/basic/ex_${IND}
	mv ${APPDIR}/basic/B${IND} ${APPDIR}/basic/ex_${IND}/
done