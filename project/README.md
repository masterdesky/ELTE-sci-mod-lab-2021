# Project work: Nuclear Physics using Geant4
This folder contains any actual work, eg. program codes, configuration files, etc. of my project work, in completely separated folder from the documentation. At the beginning of the course I had to choose a unique topic from a list of possible projects to work on during the semester. From this list I've chosen a topic related to nuclear physics and the use of the Geant4 software.

## Description of the project
On it's official website, we can read about the software the following: *"Geant4 is a toolkit for the simulation of the passage of particles through matter. Its areas of application include high energy, nuclear and accelerator physics, as well as studies in medical and space science."*

During the projectwork I had to follow a chain of tasks, which can be accessed at the [official repository](https://github.com/sdam-elte/modellinglab2019/tree/master/nuclear_physics_geant4) of the course. The list of (stylistically reformulated) tasks was the following:

### 1. Installation
Download the software from [https://geant4.cern.ch](https://geant4.cern.ch), then follow the installation description [here](https://geant4-userdoc.web.cern.ch/UsersGuides/InstallationGuide/html/). Set up the visualization properties. Run to software using pre-prepared input files. 

### 2. Run predefined settings
Explore the input and the execution steps and get acquainted with the format of the results and how to use them.  Make figures using the result data and try to reproduce a figure from a scientific artice. 

### 3. Changing Geometry
The first unit of input is geometry. The aim is to change the detector geometry in a pre-selected way, run the codes with a few new detector geometries, interpret the resulting spectra, and select the defining parameters.

Reproduce [Figure 3]() from the following publication:
[https://www.researchgate.net/publication/271920760](https://www.researchgate.net/publication/271920760)

### 4. Specifying Detector Material
Get to know the format needed to specify new materials in the detector. Set up a detector system using new materials. Run with new materials, analyze the effects of individual small and large atomic numbers by analyzing the spectra of certain results.

### 5. List of physics processes
Overview the options for choosing built-in physical processes on the download page of Geant4. Examine the detector you have made so far, if you allow more and more physical processes. Construct detectors in which different physical processes play a major role. Interpret the resulting spectra of these processes.

### 6. Run Action
Set the run parameters. Investigate different energy, mixed energy and different focusing featured beams in one and more detectors. Characterize the complete setting parameter space and set all parameters individually. Run with parameter sets and investigate the response function.

### 7. Data analysis
Overview the possible options for evaluating data. So far, only the use of spectrum-based assessment, the use of matches, statistical tests and uncertainties are included in the simulation. Write simple data evaluation macros.

### 8. Simulation of a HPGe detector
Model a HPGe detector of the Lab of Deptartment of Atomic Physics by specifying the parameters of the detector. Calculate the response function of some high energy gamma sources.

### 9. Analysing the simulation results of the HPGe detector
Analyse spectra from running the simulator. Compare results from different runs with variable parameters.

### 10. Calculate the efficiency of the HPGe
Evaluate the photopeak and full efficiency of the detector at various energy levels and with different shadowing possibilities.

### 11. Create a runtime environment
Create a user interface for batch processing or for evaluating large number of simulations. The interface should allow simulations with several options and methods. The evaluation of data should be automatic even for complex tasks.

## Description of the directory structure

TODO
