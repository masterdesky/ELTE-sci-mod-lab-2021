#!/bin/bash

export GEANT4APPS=${GEANT4_ROOT}/apps
export GEANT4BUILD=${GEANT4_ROOT}/build
export GEANT4INSTALL=${GEANT4_ROOT}/install
export GEANT4SRC=${GEANT4_ROOT}/src/

mkdir -p ${GEANT4APPS} ${GEANT4BUILD} ${GEANT4INSTALL}

if [[ ! -d ${GEANT4SRC} ]];
then
	# Downloading Geant4
	echo
	echo "Downloading Geant4..."
	echo

	#git clone https://salsa.debian.org/science-team/geant4.git ${GEANT4SRC}
  wget http://geant4-data.web.cern.ch/geant4-data/releases/source/geant4.10.07.p01.tar.gz -P ${GEANT4_ROOT}
  tar -xzvf ${GEANT4_ROOT}/geant4.10.07.p01.tar.gz -C ${GEANT4_ROOT}
  mv ${GEANT4_ROOT}/geant4.10.07.p01 ${GEANT4SRC}
  rm -f ${GEANT4_ROOT}/geant4.10.07.p01.tar.gz
fi

if [[ ${INSTALL_GEANT4} = true ]];
then
	# Installing Geant4
	echo
	echo "Installing Geant4..."
	echo

	cd ${GEANT4BUILD}
	if [ -f ${GEANT4BUILD}/mi.log ]; then
		make uninstall |& tee >(ts "[%x %X]" > ${GEANT4BUILD}/mu.log)
		make clean |& tee >(ts "[%x %X]" > ${GEANT4BUILD}/cl.log)
	fi
	# Considering that Qt and X11 are installed already
	cmake \
	-DCMAKE_INSTALL_PREFIX=${GEANT4INSTALL} \
	-DGEANT4_INSTALL_DATA=ON \
	-DGEANT4_INSTALL_DATADIR=${GEANT4INSTALL}/data \
	-DGEANT4_USE_RAYTRACER_X11=ON \
	-DGEANT4_USE_OPENGL_X11=ON \
	-DGEANT4_USE_QT=ON \
	-DGEANT4_USE_XM=ON \
	-DGEANT4_USE_GDML=ON \
	-DGEANT4_BUILD_MULTITHREADED=ON ${GEANT4SRC} \
	|& tee >(ts "[%x %X]" > ${GEANT4BUILD}/c.log)
	make -j4 VERBOSE=1 |& tee >(ts "[%x %X]" > ${GEANT4BUILD}/m.log)
	make install |& tee >(ts "[%x %X]" > ${GEANT4BUILD}/mi.log)
	cd ${GEANT4_ROOT}

	# Setup test examples
	cp -r ${GEANT4SRC}/examples/basic ${GEANT4APPS}/
	cp -r ${GEANT4SRC}/examples/advanced ${GEANT4APPS}/
	cp -r ${GEANT4SRC}/examples/extended ${GEANT4APPS}/

	for IND in 1 2 3 4 5
	do
		echo
		echo "Preparing basic example B${IND}"
		echo
		mkdir -p ${GEANT4APPS}/basic/ex_${IND}
		mv ${GEANT4APPS}/basic/B${IND} ${GEANT4APPS}/basic/ex_${IND}/
	done
fi

# Source Geant4
if [[ -f ${GEANT4INSTALL}/bin/geant4.sh ]];
then
  cd ${GEANT4INSTALL}/bin/
  source geant4.sh
  cd ~-

  echo
	echo "Sourced Geant4!"
	echo
fi

if [[ ${ADD_NEBULA_INSTALL} = true ]];
then
	# Add Geant4 install path to project install script
	cp ${SCRIPTDIR}/project-install.sh ${PROJDIR}/project-install.sh
	sed -i  '/^PROJNAME/ { s|$|\"'"${PROJNAME}"'\"| }' ${PROJDIR}/project-install.sh
	sed -i  '/^PROJDIR/ { s|$|\"'"${PROJDIR}"'\"| }' ${PROJDIR}/project-install.sh
	sed -i  '/^GEANT4INSTALL/ { s|$|\"'"${GEANT4INSTALL}"'\"| }' ${PROJDIR}/project-install.sh
	chmod +x ${PROJDIR}/project-install.sh

	# Add Geant4 install path to project run script
	cp ${SCRIPTDIR}/project-run.sh ${PROJDIR}/project-run.sh
	sed -i  '/^PROJNAME/ { s|$|\"'"${PROJNAME}"'\"| }' ${PROJDIR}/project-run.sh
	sed -i  '/^PROJDIR/ { s|$|\"'"${PROJDIR}"'\"| }' ${PROJDIR}/project-run.sh
	sed -i  '/^GEANT4INSTALL/ { s|$|\"'"${GEANT4INSTALL}"'\"| }' ${PROJDIR}/project-run.sh
	chmod +x ${PROJDIR}/project-run.sh

	echo
	echo "Generated install and run script for NEBULA project!"
	echo
fi

# Return to script directory
cd ${SCRIPTDIR}