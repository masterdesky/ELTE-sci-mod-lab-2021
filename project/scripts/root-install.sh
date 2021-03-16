#!/bin/bash

export ROOTBUILD="${ROOT_ROOT}/root_build"
export ROOTINSTALL="${ROOT_ROOT}/root_install"
export ROOTSRC="${ROOT_ROOT}/root_src"

mkdir -p ${ROOTBUILD} ${ROOTINSTALL}

if [ ! -d ${ROOTSRC} ];
then
	# Downloading ROOT
	echo
	echo "Downloading ROOT..."
	echo

	git clone --branch v6-22-00-patches https://github.com/root-project/root.git ${ROOTSRC}
fi

if [ ${INSTALL_ROOT} = "TRUE" ];
then
	# Installing ROOT
	echo
	echo "Installing ROOT..."
	echo

	cd ${ROOTBUILD}
	if [ -f ${ROOTBUILD}/mi.log ]; then
		# ROOT doesn't have an `uninstall` call
		make uninstall |& tee >(ts "[%x %X]" > ${ROOTBUILD}/mu.log)
		#rm -rf ${ROOTINSTALL}/* |& tee >(ts "[%x %X]" > ${ROOTBUILD}/mu.log)
		make clean |& tee >(ts "[%x %X]" > ${ROOTBUILD}/cl.log)
	fi

	cmake -DCMAKE_INSTALL_PREFIX=${ROOTINSTALL} \
				${ROOTSRC} \
				|& tee >(ts "[%x %X]" > ${ROOTBUILD}/c.txt)
	make -j4 VERBOSE=1 |& tee >(ts "[%x %X]" > ${ROOTBUILD}/m.log)
	make install |& tee >(ts "[%x %X]" > ${ROOTBUILD}/mi.log)
	#cmake --build ${ROOTBUILD} -- install -j4 \
	#			|& tee >(ts "[%x %X]" ${ROOTBUILD}/mi.txt)
fi

# Source ROOT
if [ -f ${ROOTINSTALL}/bin/thisroot.sh ];
then
	source ${ROOTINSTALL}/bin/thisroot.sh


  echo
	echo "Sourced ROOT!"
	echo
fi

# Return to script directory
cd ${SCRIPTDIR}