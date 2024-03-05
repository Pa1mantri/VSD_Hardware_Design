
## PHYSICAL DESIGN ##

This repository contains all the information needed to build and run openlane flow, which has the capability to perform full ASIC implementation steps from RTL to GDSII. In addition, it also contains procedures on how to create a custom LEF file and plugging it into an openlane flow

**Introduction to OpenLane flow**

OpenLane is a completely automated RTL to GDSII flow which embeds in it different opensource tools, namely, OpenROAD, Yosys, ABC,etc., apart from many custom methodology scripts for design exploration and optimization. Openlane is built around Skywater 130nm process node and is capable of performing full ASIC implementation steps from RTL all the way down to GDSII. The flow-chart below gives a better picture of openlane flow as a whole

<img width="600" alt="Screenshot 2023-06-01 163017" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/d1b98ee7-d286-4187-9e5f-5cc433e90296">

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
     
     Copy the lib files and the created sky130_vsdinv.lef file to your design src directory.
     
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

1.We run the OpenLane in the interactive mode to include our custom made lef file(SKY130_vsdinv.lef) before synthesis, so that the openlane recognises our lef files during   the flow for mapping.

  Commands to run the openlane in interactive mode
  ```
  cd OpenLane
  make mount
  ./flow.tcl -interactive
  ```
  <img width="464" alt="Screenshot 2023-06-01 092521" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/fdd119c0-6b92-4e18-a663-10d1bc456f33">

2.Preparing the design and including the lef files:

  ```
  prep -design picorv32a
  set lefs [glob $::env(DESIGN_DIR)/src/*.lef]
  add_lefs -src $lefs
  ```
  <img width="463" alt="Screenshot 2023-06-01 092628" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/f81acdd0-9dc5-47ea-93a5-f87b73e3e2a0">

3.Synthesis: ```run_synthesis``` yosys translates RTL into circuit with generic components and abc maps the circuit to standard cells.
  
  <img width="466" alt="Screenshot 2023-06-01 092704" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/6fd10ac3-39d3-49a3-87e6-f7ba24f829f2">
  
  The synthesized Netlist is present in the results folder and the stats are present in the log folder.
  
  <img width="243" alt="Screenshot 2023-06-01 092820" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/4fd12558-0003-4cbe-87fa-149e4035e511">
  
  slack report with the custom cell 
  
  <img width="542" alt="Screenshot 2023-06-01 092956" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/e6cf1adf-8cf2-4083-88d9-97ec17465e50">
  
  <img width="561" alt="Screenshot 2023-06-01 093106" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/92c2f0a2-4d28-4621-8495-0c8cea6bdec1">
  
4.Floorplan: ```run_floorplan```

  <img width="464" alt="Screenshot 2023-06-01 092720" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/d67af59b-8514-4c5e-a6c6-e34fe8888bf6">

  Post the floorplan, a ```.def``` file is created in the results folder. We can review the code for floorplan in the ```floorplan.tcl``` file present in the                 ```scripts/tcl_commands``` folder. All the switches with which we can ammend the floorplan process can be found in ```floorplan.tcl``` file present in the                   ```configuration/floorplan.tcl``` folder.
  
  To view the floorplan use the magic tool with the following command.
  
  ``` magic -T /home/pa1mantri/.volare/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.nom.lef def read picorv32.def ```
  
  <img width="699" alt="Screenshot 2023-06-01 093534" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/c0fe6dd7-7687-481f-ba01-66b0dbad400e">
  
  Die-Area post Floorplan
  
  <img width="606" alt="Screenshot 2023-06-02 194834" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/3652eb67-303e-4e7c-b878-76b862e69cd4">


  All the standard cells are found at the corner of the chip, whcih will be placed at the placement stage. PDN(power distribution network) also happens at this stage with     rails,straps and rings in the chip.
  
  <img width="662" alt="Screenshot 2023-06-01 093905" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/1a17d3fb-58a4-472a-a050-698a608ba768">

  <img width="922" alt="Screenshot 2023-06-01 093720" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/9dd084a9-6cd5-4343-8b50-5ce87fe99540">

5.Placement: The synthesized netlist is to be placed on the floorplan. Placement happens in two steps
  
  Global Placement: It finds optimal position for all cells which may not be legal and cells may overlap. Optimization is done through reduction of half parameter wire       length.
  
  Detailed Placement:  It alters the position of cells post global placement so as to legalise them.
  
  <img width="465" alt="Screenshot 2023-06-01 094209" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/9de8acde-9039-4ea6-8c7f-99dec2d106a4">
  
  After the placement, the results can be viewed on magic within Results/placement directory with the following command
  
  ``` magic -T /home/pa1mantri/.volare/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.nom.lef def read picorv32.def ```
  
  <img width="663" alt="Screenshot 2023-06-01 094353" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/543f34f8-ef50-4afc-aec0-2381de1a5415">

  SKY130_vsdinv cell post placement

  <img width="924" alt="Screenshot 2023-06-01 100109" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/d2649faf-298f-451d-a18e-b260aa03f5c4">
  
  after using expand command in the tkcon window:
  
  <img width="924" alt="Screenshot 2023-06-01 100135" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/9666d311-3c0a-4a6d-9da5-ce31f16708d7">
  
  <img width="374" alt="Screenshot 2023-06-01 100215" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/584291a1-2d95-4bd1-a3f3-5cc889242119">
  
  Area post Placement
  
  <img width="383" alt="Screenshot 2023-06-02 194945" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/55d88eb3-d621-4306-a749-6940cfcf0a95">
  
  resizing_sta report post placement
  
  <img width="443" alt="Screenshot 2023-06-02 195949" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/8b43080b-560d-4b84-b24c-48c0e7afdf52">
  
  
  <img width="435" alt="Screenshot 2023-06-02 200410" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/98e7cb4e-342a-4bff-be64-69c204fefedc">
  
  slack report post placement
  
  <img width="404" alt="Screenshot 2023-06-02 200807" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/0dab252f-f7a5-43fe-8aa5-115399f1d9b5">

  
6.Clock Tree Synthesis

  The purpose of building a clock tree is enable the clock input to reach every element and to ensure a zero clock skew. H-tree is a common methodology followed in CTS.       Before attempting a CTS run in TritonCTS tool, if the slack was attempted to be reduced in previous run, the netlist may have gotten modified by cell replacement           techniques. Therefore, the verilog file needs to be modified using the write_verilog command. Then, the synthesis, floorplan and placement is run again. To run the cts c   command is ```run_cts```

  <img width="462" alt="Screenshot 2023-06-01 100547" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/cfa64247-1b98-451e-bb3c-c32e5ee96d84">
  
  slack report post CTS
  
  <img width="418" alt="Screenshot 2023-06-04 070636" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/ccffcbc8-36c1-4dc1-85cc-ccab36a74258">
  
  Power report post CTS
  
  <img width="381" alt="Screenshot 2023-06-04 070529" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/e5c173b7-0788-4d83-a032-fba89aaa015c">

  Skew Report post CTS
  
  <img width="399" alt="Screenshot 2023-06-04 070604" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/d6d53f44-25cf-4659-b459-80336b9284a4">
  
  Sta report post cts
  
  <img width="436" alt="Screenshot 2023-06-04 071115" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/69d6cd5b-1055-4f8c-a8e0-18487efd7bb7">
  
  <img width="394" alt="Screenshot 2023-06-04 071126" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/0092f873-f329-48bf-b401-644f2e1543f1">
  
  
  
7.Routing: There are two stages of Routing 
  1.Global Routing   : Routing region is divided into rectangle grids which are represented as course 3D routes (Fastroute tool).
  2.Detailed Routing : Finer grids and routing guides used to implement physical wiring (TritonRoute tool).
  
  <img width="796" alt="Screenshot 2023-06-01 102811" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/79eb4cde-bd24-435e-9655-2b1828eb0fdd">

  The design can be viewed on magic within ``results/routing`` directory by running the following command.
  
  ``` magic -T /home/pa1mantri/.volare/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.nom.lef def read picorv32.def ```
   
  <img width="913" alt="Screenshot 2023-06-01 120533" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/7009a67f-64d6-4f47-87af-0e0cb948aa5e">

  SkY130_vsdinv cell post routing

  <img width="922" alt="Screenshot 2023-06-02 185131" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/0942d0e1-1c81-43dc-981a-b6d83063dfd7">
  
  SKY130_vsdinv cell post routing after using the expand command in tkcon window
  
  <img width="923" alt="Screenshot 2023-06-02 185225" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/4bd2b486-260d-4965-b4f6-adde1bd15c54">
  
  Congestion Report post routing
  
  <img width="430" alt="Screenshot 2023-06-04 072055" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/3f010157-42ea-44f4-909f-ac3009ccf276">

  slack report post routing
  
  <img width="381" alt="Screenshot 2023-06-04 072156" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/d97d8f5d-e4ed-4d60-a000-41e93d4cfd56">


8.``run_magic`` command is used to generate the GDSII file in the ``results/signoff`` directory.

  <img width="602" alt="Screenshot 2023-06-01 105057" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/39771f44-d05c-4f75-b416-37a0af7326f4">
   
     
  <img width="695" alt="Screenshot 2023-06-01 105919" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/3950ce97-563f-4635-b841-6eed053db555">
  
  
