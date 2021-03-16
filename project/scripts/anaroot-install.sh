#!/bin/bash

mkdir -p ${ANAROOT_ROOT}

if [ ! -d ${ANAROOT_ROOT}/anaroot ];
then
	# Downloading AnaROOT
	echo
	echo "Downloading AnaROOT..."
	echo

	wget "https://ribf.riken.jp/RIBFDAQ/index.php?plugin=attach&refer=Tools%2FAnalysis%2FANAROOT%2FInstallation&openfile=anaroot_v4.5.39.tgz" -P ${ANAROOT_ROOT}
	mv "${ANAROOT_ROOT}/index.php?plugin=attach&refer=Tools%2FAnalysis%2FANAROOT%2FInstallation&openfile=anaroot_v4.5.39.tgz" "${ANAROOT_ROOT}/anaroot_v4.5.39.tgz"
  tar -xzvf ${ANAROOT_ROOT}/anaroot_v4.5.39.tgz -C ${ANAROOT_ROOT}
  rm -f ${ANAROOT_ROOT}/anaroot_v4.5.39.tgz
fi

if [ ${INSTALL_ANAROOT} = "TRUE" ];
then
	# Installing AnaROOT
	echo
	echo "Installing AnaROOT..."
	echo

	cd ${ANAROOT_ROOT}/anaroot
	if [ -f ${ANAROOT_ROOT}/anaroot/mi.log ]; then
		make uninstall |& tee >(ts "[%x %X]" > ${ANAROOT_ROOT}/anaroot/mu.log)
		make clean |& tee >(ts "[%x %X]" > ${ANAROOT_ROOT}/anaroot/cl.log)
	fi

	./autogen.sh --prefix=${ANAROOT_ROOT}/anaroot |& tee >(ts "[%x %X]" > ${ANAROOT_ROOT}/anaroot/c.log)
	make install |& tee >(ts "[%x %X]" > ${ANAROOT_ROOT}/anaroot/mi.log)
fi

# Source AnaROOT
if [ -f ${ANAROOT_ROOT}/anaroot/setup.sh ];
then
	source ${ANAROOT_ROOT}/anaroot/setup.sh

  echo
	echo "Sourced AnaROOT!"
	echo
fi

# Return to script directory
cd ${SCRIPTDIR}