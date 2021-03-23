#!/bin/bash

# Prerequisites for ROOT, AnaROOT and Geant4
# sudo apt install libxft-dev libxpm-dev libxmu-dev libxerces-c-dev libxml2-devel
# sudo apt install automake autoconf libtool libedit
# sudo apt install libqt4-dev qtbase5-dev

export SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
export PIPELINEDIR="${SCRIPTDIR%/*}"

# Setup bash environment for further scripts
source ${SCRIPTDIR}/setup_env.sh

# Set up Geant4
source ${SCRIPTDIR}/geant4-install.sh

# Set up ROOT
source ${SCRIPTDIR}/root-install.sh

# Set up AnaROOT
source ${SCRIPTDIR}/anaroot-install.sh
