#!/bin/bash

# Prerequisites
# sudo apt install libxft-dev libxpm-dev libxmu-dev libxerces-c-dev libxml2-devel
# sudo apt install automake autoconf libtool libedit
# sudo apt install libqt4-dev qtbase5-dev

export PIPELINEDIR="${HOME}/GitHub/ELTE_Modelling_Lab_2021/project"
export SCRIPTDIR="${PIPELINEDIR}/scripts"

# Setup bash environment for further scripts
source ${SCRIPTDIR}/setup_env.sh

# Set up Geant4
source ${SCRIPTDIR}/geant4-install.sh

# Set up ROOT
source ${SCRIPTDIR}/root-install.sh

# Set up AnaROOT
source ${SCRIPTDIR}/anaroot-install.sh