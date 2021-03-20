//
// ********************************************************************
// * License and Disclaimer                                           *
// *                                                                  *
// * The  Geant4 software  is  copyright of the Copyright Holders  of *
// * the Geant4 Collaboration.  It is provided  under  the terms  and *
// * conditions of the Geant4 Software License,  included in the file *
// * LICENSE and available at  http://cern.ch/geant4/license .  These *
// * include a list of copyright holders.                             *
// *                                                                  *
// * Neither the authors of this software system, nor their employing *
// * institutes,nor the agencies providing financial support for this *
// * work  make  any representation or  warranty, express or implied, *
// * regarding  this  software system or assume any liability for its *
// * use.  Please see the license in the file  LICENSE  and URL above *
// * for the full disclaimer and the limitation of liability.         *
// *                                                                  *
// * This  code  implementation is the result of  the  scientific and *
// * technical work of the GEANT4 collaboration.                      *
// * By using,  copying,  modifying or  distributing the software (or *
// * any work based  on the software)  you  agree  to acknowledge its *
// * use  in  resulting  scientific  publications,  and indicate your *
// * acceptance of all terms of the Geant4 Software license.          *
// ********************************************************************
//
//
/// \file DetectorConstruction.cc
/// \brief Implementation of the DetectorConstruction class

#include "DetectorConstruction.hh"

#include "G4RunManager.hh"
#include "G4NistManager.hh"
#include "G4Box.hh"
#include "G4Cons.hh"
#include "G4Trd.hh"
#include "G4LogicalVolume.hh"
#include "G4PVPlacement.hh"
#include "G4SystemOfUnits.hh"

//....oooOO0OOooo........oooOO0OOooo........oooOO0OOooo........oooOO0OOooo......

DetectorConstruction::DetectorConstruction()
: G4VUserDetectorConstruction(),
  fScoringVolume(0)
{ }

//....oooOO0OOooo........oooOO0OOooo........oooOO0OOooo........oooOO0OOooo......

DetectorConstruction::~DetectorConstruction()
{ }

//....oooOO0OOooo........oooOO0OOooo........oooOO0OOooo........oooOO0OOooo......

G4VPhysicalVolume *DetectorConstruction::Construct()
{  
  // Get nist material manager
  G4NistManager *nist = G4NistManager::Instance();

  // Option to switch on/off checking of volumes overlaps
  //
  G4bool checkOverlaps = true;

  //
  // World
  //
  G4double world_size = 3 * m;
  G4Material *world_mat = nist->FindOrBuildMaterial("G4_Galactic");

  G4Box *solidWorld =    
    new G4Box("World",                       //its name
       0.5*world_size, 0.5*world_size, 0.5*world_size);     //its size

  G4LogicalVolume *logicWorld =                         
    new G4LogicalVolume(solidWorld,          //its solid
                        world_mat,           //its material
                        "World");            //its name
                                   
  G4VPhysicalVolume *physWorld = 
    new G4PVPlacement(0,                     //no rotation
                      G4ThreeVector(),       //at (0,0,0)
                      logicWorld,            //its logical volume
                      "World",               //its name
                      0,                     //its mother volume
                      false,                 //no boolean operation
                      0,                     //copy number
                      checkOverlaps);        //overlaps checking


  //
  // Detector
  //
  // Creating the BC-408 plastic scintillator (counter material)
  // Dimensions of the NEUT rods: 12cm(H) x 12cm(T) x 180cm(V)
  G4double counterSizeXY = 12*cm, counterSizeZ = 180*cm;
  G4double HMolarMass = 1.008 * g / mole;
  G4double CMolarMass = 12.0107 * g / mole;
  G4Element *elH = new G4Element ("Hydrogen", "H", 1, HMolarMass);
  G4Element *elC = new G4Element ("Carbon", "C", 6, CMolarMass);
  G4double densityCounter = 1.023 * g / cm3;
  G4Material *counterMat = new G4Material("counterMaterial", densityCounter, 2);
  counterMat->AddElement(elH, 0.5245);
  counterMat->AddElement(elC, 0.4755);
  G4Box *solidCounter = new G4Box("Counter",
                                  0.5*counterSizeXY, 0.5*counterSizeXY, 0.5*counterSizeZ);

  // The NEBULA detector consists of 120 NEUT modules and 24 VETO modules,
  // that are distributed to 60 NEUT and 12 VETO modules per each wall
  // Here, only the NEUT modules of one of the sides are simulated (60 NEUT in 2 layers)
  int rows = 2, cols = 30;
  for(int i = 0; i < cols; i++) {

    for(int j = 0; j < rows; j++) {

      // row−major coding
      int code = j + rows*i;
      G4cout << code << G4endl;
      G4LogicalVolume *logicCounter = new G4LogicalVolume(solidCounter, counterMat, "Counter" + std::to_string(code));
      G4ThreeVector posCounter = G4ThreeVector(
                                                (i-0.5*( (double)cols-1) )*counterSizeXY,
                                                (j-0.5*( (double)rows-1) )*counterSizeXY,
                                                0
                                              );
      new G4PVPlacement(0,
                        posCounter,
                        logicCounter,
                        "Counter" + std::to_string(code),
                        logicWorld,
                        false,
                        code,
                        checkOverlaps) ;
    }
  }

  //
  //always return the physical World
  //
  return physWorld;
}

//....oooOO0OOooo........oooOO0OOooo........oooOO0OOooo........oooOO0OOooo......
