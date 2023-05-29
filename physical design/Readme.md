
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

**Customising the layout by including a custom made inverter cell (sky130_vsdinv) into our layout.**








## Intialising OpenLane and Running Synthesis

<img width="632" alt="Screenshot 2023-05-13 033243" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/cd4b8083-0c6a-449a-8c96-4cb5260836df">
<img width="671" alt="Screenshot 2023-05-13 035649" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/e62541d0-82b1-447b-bffc-31752bb1b873">
<img width="482" alt="Screenshot 2023-05-13 040424" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/cd96db39-513c-4b61-ac57-9b1f74396f57">
<img width="414" alt="Screenshot 2023-05-13 040621" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/cc0142f3-a525-45ac-8a8b-cf7108230608">
<img width="784" alt="after synthesis" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/bd09e6ee-4383-4b62-9630-932fe22aeb92">


## Floor plan

<img width="811" alt="Screenshot 2023-05-13 044156" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/3a94d87a-5887-482c-8f58-e32a669355fc">
<img width="928" alt="Screenshot 2023-05-13 045557" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/31431308-32dd-47d7-b2c6-7db4f0c738fe">
<img width="929" alt="def_file" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/6a00598f-4f4e-419c-a65d-872c67ff8596">
<img width="933" alt="Screenshot 2023-05-13 070340" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/d64c63e9-8192-4c6a-a999-01e0b7795f9e">
<img width="927" alt="Screenshot 2023-05-13 071016" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/1f215733-ba75-46ad-bc2b-d7443cded787">
<img width="929" alt="Screenshot 2023-05-13 071533" src="https://github.com/Pa1mantri/vsd_hardware_design/assets/114488271/58310b47-10ed-4b70-aa24-1d06b8a1bae8">

