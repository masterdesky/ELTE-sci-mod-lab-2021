#!/bin/bash
cmake \
-DGEANT4_INSTALL_DATA=ON \
-DGEANT4_INSTALL_DATADIR="/home/masterdesky/Applications/geant4/install/share/Geant4-10.7.1/data/" \
-DCMAKE_INSTALL_PREFIX="/home/masterdesky/Applications/geant4/install/" \
-DCMAKE_PREFIX_PATH="/usr/lib/x86_64-linux-gnu/" \
-DGEANT4_USE_OPENGL_X11=ON \
-DGEANT4_USE_QT=ON  \
-DGEANT4_USE_GDML=ON -DGEANT4_BUILD_MULTITHREADED=ON /home/masterdesky/Applications/geant4/geant4.10.07/
