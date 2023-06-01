
## PHYSICAL DESIGN ##

**Overview Of Physical Design Flow**

Place and Route(PnR) is the core of any ASIC implemantation and OpenLane flow integrates into it several key opensource tools which perform each of the respective stages of PnR. Below are the stages and respective tools that are called by OpenLane 

* Synthesis
  * Genetaring gate level netlist(Yosys)
  * cell mapping (abc)
  * Performing Pre-layout STA(OpenSTA)

* Floorplanning
  * Defining the core are for the macro as well as the cell sites and tracks (init_fp).
  * Placing the macro input and output ports (io_placer).
  * Generating the power distribution network (pdn).

* Placement
  * Global placement (RePLace).
  * Detailed Placement : To legalise the globally placed components (OpenDP).

* Cts
  * Synthesising the clock tree (Triton CTS).

* Routing 
  * Global Routing to generate a guide file for detailed router (FastRoute).
  * Detailed Routing (TritonRoute).

* GDSII Generation
  * Streaming out the final GDSII layout file from the routed def (Magic).


**OpenLane**

OpenLane is an automated RTL to GDSII flow based on several components including OpenROAD, Yosys, Magic, Netgen, CVC, SPEF-Extractor, CU-GR, Klayout and a number of custom scripts for design exploration and optimization. The flow performs full ASIC implementation steps from RTL all the way down to GDSII.

More about OpenLane at https://github.com/The-OpenROAD-Project/OpenLane

**Installation Instructions**

`` apt install -y build-essential python3 python3-venv python3-pip ``

Docker installation process https://docs.docker.com/engine/install/ubuntu

Follow these commands after moving to the home directory

```
$ git clone https://github.com/The-OPENROAD-Project/OpenLane.git
$ cd OpenLane
$ make
$ make test
```

**Magic**

Magic is a VLSI layout tool, widely cited as being the easiest tool to use for circuit layout.

More about Magic at https://opencircuitdesign.com/magic/index.html

Before installing Magic run the following commands to fulfill system requirements

```
$   sudo apt-get install m4
$   sudo apt-get install tcsh
$   sudo apt-get install csh
$   sudo apt-get install libx11-dev
$   sudo apt-get install tcl-dev tk-dev
$   sudo apt-get install libcairo2-dev
$   sudo apt-get install mesa-common-dev libglu1-mesa-dev
$   sudo apt-get install libncurses-dev
```
To install Magic go to home directory

```
$ git clone https://github.com/RTimothyEdwards/magic
$ cd magic
$ ./configure
$ make
$ make install
```
type Magic in the terminal to check whether it is installed or not.

# Customising the layout by including a custom made inverter cell (sky130_vsdinv) into our layout. #

1. Creating SKY130_vsdinv cell lef file
   * First get the git repository ``vsdstdcelldesign``. Type the following command to get the repository. 
   
     ``git clone https://github.com/nickson-jose/vsdstdcelldesign.git``
     
     This creates a vsdstdcelldesign named folder in the openlane directory.
     To invoke magic to view the sky130_inv.mag file, the sky130A.tech file must be included in the command along with its path. To ease up the complexity of this command,      the tech file can be copied from the magic folder to the vsdstdcelldesign folder.
     
     The sky130_inv.mag file can then be invoked in Magic using
     
     ```magic -T sky130A.tech sky130_inv.mag &```
     
     <img width="916" alt="Screenshot 2023-05-16 185842" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/5e14e6b5-625b-40b4-8447-5566f504b028">
     
     *LEF or library exchange format:* A format that tells us about cell boundaries, VDD and GND lines. It contains no info about the logic of circuit and is also used to        protect the IP.
     
     SPICE extraction: Within the Magic environment, following commands are used in tkcon to achieve .mag to .spice extraction:
     
     ```
     extract all
     ext2spice cthresh 0 rethresh 0
     ext2spice
     
     ```
     
     The next step is setting ```port class``` and ```port use``` attributes. The "class" and "use" properties of the port have no internal meaning to magic but are used by      the LEF and      DEF format read and write routines, and match the LEF/DEF CLASS and USE properties for macro cell pins. These attributes are set in tkcon window            (after selecting each port on layout window. A keyboard shortcut would be,repeatedly pressing s till that port gets highlighed).
     
     The tkcon command window of the port classification is shown in the image below:
     
     <img width="534" alt="Screenshot 2023-05-18 075517" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/02a54d7b-e1f9-45c5-a357-deb8eba6db06">
     
     In the next step, use ```lef write``` command to write the LEF file with the same nomenclature as that of the layout .mag file. This will create a sky130_vsdinv.lef        file in the same folder.
     
     <img width="661" alt="Screenshot 2023-05-18 081847" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/3ff48acb-3f77-4ce2-8388-224ce6efeacb">


2. Including the SKY130_vsdinv cell in the design 
     
     Copy the lib files and the created sky130_vsinv.lef file to your design src directory.
     
3. Modify the config.json file by including the following lines.
     
     ```
     "LIB_SYNTH":"dir::src/sky130_fd_sc_hd__typical.lib",
     "LIB_FASTEST":"dir::src/sky130_fd_sc_hd__fast.lib",
     "LIB_SLOWEST":"dir::src/sky130_fd_sc_hd__slow.lib",
     "LIB_TYPICAL":"dir::src/sky130_fd_sc_hd__typical.lib",
     "TEST_EXTERNAL_GLOB":"dir::src/*",
     "SYNTH_DRIVING_CELL":"sky130_vsdinv"
     ```
     
     




## Intialising OpenLane and Running Synthesis

## Floor plan


