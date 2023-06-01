
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

<img width="243" alt="Screenshot 2023-06-01 092820" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/4fd12558-0003-4cbe-87fa-149e4035e511">
<img width="542" alt="Screenshot 2023-06-01 092956" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/e6cf1adf-8cf2-4083-88d9-97ec17465e50">
<img width="561" alt="Screenshot 2023-06-01 093106" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/92c2f0a2-4d28-4621-8495-0c8cea6bdec1">
<img width="699" alt="Screenshot 2023-06-01 093534" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/c0fe6dd7-7687-481f-ba01-66b0dbad400e">
<img width="924" alt="Screenshot 2023-06-01 093642" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/40b262a1-fca2-4868-ae1a-df7c381bebd1">
<img width="922" alt="Screenshot 2023-06-01 093720" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/9dd084a9-6cd5-4343-8b50-5ce87fe99540">
<img width="753" alt="Screenshot 2023-06-01 093833" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/97fdb09f-35a6-4ae9-9fb1-6dc6b3a0b81a">
<img width="662" alt="Screenshot 2023-06-01 093905" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/1a17d3fb-58a4-472a-a050-698a608ba768">
<img width="465" alt="Screenshot 2023-06-01 094209" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/9de8acde-9039-4ea6-8c7f-99dec2d106a4">
<img width="663" alt="Screenshot 2023-06-01 094353" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/543f34f8-ef50-4afc-aec0-2381de1a5415">
<img width="924" alt="Screenshot 2023-06-01 100109" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/d2649faf-298f-451d-a18e-b260aa03f5c4">
<img width="924" alt="Screenshot 2023-06-01 100135" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/9666d311-3c0a-4a6d-9da5-ce31f16708d7">
<img width="374" alt="Screenshot 2023-06-01 100215" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/584291a1-2d95-4bd1-a3f3-5cc889242119">
<img width="462" alt="Screenshot 2023-06-01 100547" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/cfa64247-1b98-451e-bb3c-c32e5ee96d84">
<img width="796" alt="Screenshot 2023-06-01 102811" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/79eb4cde-bd24-435e-9655-2b1828eb0fdd">
<img width="602" alt="Screenshot 2023-06-01 105057" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/39771f44-d05c-4f75-b416-37a0af7326f4">
<img width="695" alt="Screenshot 2023-06-01 105919" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/3950ce97-563f-4635-b841-6eed053db555">
<img width="922" alt="Screenshot 2023-06-01 110310" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/f104fa39-ae3a-438a-b7dc-4b4e2bcc8738">
<img width="913" alt="Screenshot 2023-06-01 120533" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/7009a67f-64d6-4f47-87af-0e0cb948aa5e">
<img width="928" alt="Screenshot 2023-06-01 120652" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/fdbb92e1-524a-4fe9-8178-50b1d73a8225">
<img width="924" alt="Screenshot 2023-06-01 120708" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/c2793fe2-c58f-476c-9602-25bd8610b373">
<img width="464" alt="Screenshot 2023-06-01 092521" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/fdd119c0-6b92-4e18-a663-10d1bc456f33">
<img width="463" alt="Screenshot 2023-06-01 092628" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/f81acdd0-9dc5-47ea-93a5-f87b73e3e2a0">
<img width="466" alt="Screenshot 2023-06-01 092704" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/6fd10ac3-39d3-49a3-87e6-f7ba24f829f2">
<img width="464" alt="Screenshot 2023-06-01 092720" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/d67af59b-8514-4c5e-a6c6-e34fe8888bf6">

