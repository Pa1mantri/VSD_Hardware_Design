# VSD Hardware Design Flow
-------------------------------------------------------
## Day-0 **Tool Installations**
-------------------------------------------------------
Environment: Windows-11 and Ubuntu-22.04
## Tool: **Yosys**

Installation Flow:
```
$ git clone https://github.com/YosysHQ/yosys.git  
$ cd yosys  
$ sudo apt install make (If make is not installed please install it)   
$ sudo apt-get install build-essential clang bison flex \  
    libreadline-dev gawk tcl-dev libffi-dev git \  
    graphviz xdot pkg-config python3 libboost-system-dev \  
    libboost-python-dev libboost-filesystem-dev zlib1g-dev  
$ make   
$ sudo make install  
```
<img width="408" alt="yosys" src="https://user-images.githubusercontent.com/114488271/204250545-7b7cf48e-fc05-495c-b88c-94a5403b079c.png">    


## Tool: **OpenSTA**  

Installation guide:  
(https://github.com/The-OpenROAD-Project/OpenSTA)#installing-with-cmake

Additional Dependency
```
$ sudo apt-get install swig
```

Installation Flow

```
$ git clone https://github.com/The-OpenROAD-Project/OpenSTA.git  
$ cd OpenSTA  
$ mkdir build  
$ cd build  
$ cmake ..  
$ make  
$ sudo make install  
```  

Image:

<img width="496" alt="STA" src="https://user-images.githubusercontent.com/114488271/204252666-51347fe2-9831-4603-a0ec-2fe5a72cfd1c.png">   


## Tool : **ngspice**

Installation source:
(https://sourceforge.net/projects/ngspice/files/ng-spice-rework/38/ )

Installation guide:
(https://github.com/ngspice/ngspice/blob/master/INSTALL)  #Install from tarball

After downloading the tarball from https://sourceforge.net/projects/ngspice/files/ to a local directory, unpack it using:  

Installation flow
```
$ tar -zxvf ngspice-37.tar.gz  
$ cd ngspice-37  
$ mkdir release  
$ cd release  
$ ../configure  --with-x --with-readline=yes --disable-debug  
$ make  
$ sudo make install  

```  

Image:  
<img width="489" alt="ngspice" src="https://user-images.githubusercontent.com/114488271/204254212-423b71b1-5184-4bac-b709-2fbef1fcd3e7.png">  

## Day -1  Introduction to verilog RTL design and Synthesis
-------------------------------------------------------------
## Introduction to opensource simulator iverilog
-------------------------------------------------------------
**Simulator** : It is a tool for checking whether our RTL design meets the required specifications or not. Icarus Verilog is a simulator used for simulation and synthesis of RTL designs written in verilog which is one of the many hardware description languages.

**Design** : It is the code or set of verilog codes that has the intended functionality to meet the required specifications.

**Testbench** : Testbench is a setup which is used to apply stimulus (test_vectors) to the design to check it's functionality.It tests whether the design provides the output that matches the specifications.The RTL Design gets instantiated in the testbench.

<img width="877" alt="Screenshot_20221129_063956" src="https://user-images.githubusercontent.com/114488271/204537955-6f3d3b5c-dc9f-46a4-b1a0-558321bb008e.png">

**iverilog Based Design Flow**

1.The iverilog simulator takes RTL design and Testbench as inputs.  
2.It produces a VCD file(Value change dump format) as output. Only changes in the input are dumped to changes in the output.  
3.We use Gtkwave to see these output changes graphically.

**Labs using iverilog and gtkwave**
---
```
mkdir vsd  
cd vsd  
git clone https://github.com/kunalg123/vsdflow.git  
mkdir vlsi
cd vlsi
git clone https://github.com/kunalg123/sky130RTLDesignAndSynthesisWorkshop.git  
cd sky130RTLDesignAndSynthesisWorkshop  
cd my_lib  
cd lib  
cd ..
cd verilog_model
cd..
cd..
cd verilog_files
```
Below screenshot shows the above directory structure inside the vsd upto my_lib directories that was set up through the terminal.

<img width="740" alt="directory structure-1" src="https://user-images.githubusercontent.com/114488271/204541106-cd06ff7f-4562-436c-9347-b2432fb9e3b4.png">
<img width="715" alt="directory structure-2" src="https://user-images.githubusercontent.com/114488271/204541123-f9fed187-0abe-4a52-8369-3072f8db30b6.png">

Below screenshot shows the list of verilog files. Each verilog design file has an assosciated test bench file.

<img width="898" alt="directory structure-3" src="https://user-images.githubusercontent.com/114488271/204541098-2df364e2-1a0b-45f5-8d1e-a2a5a3b0cbdb.png">

Since the environment is now set up,we try to simulate a verilog code named good_mux in one of our verilog_files with the help of it's test bench and gtkwave. The steps are mentioned below:

We simulate the RTL design and assosciated test bench.

```
iverilog good_mux.v tb_good_mux.v
```  
    
 As a result of the above , a. file is created which can be seen in the list of verilog files and we dump the output into a vcd file using
  ```
 ./a.out  
 ```

 <img width="912" alt="iverilog-output" src="https://user-images.githubusercontent.com/114488271/204541993-865bb4c8-8dba-45f0-be1c-0f8730d9ac4a.png">  
 
 The following command invokes gtkwave window where in we can see all our outputs.  
 ```
 gtkwave tb_good_mux_vcd
 ```  
 <img width="863" alt="gtkwave mux op" src="https://user-images.githubusercontent.com/114488271/204545214-f32a6fb3-76bd-4329-ad4c-9df9e31a636a.png">

 We can also view our Verilog RTL design and testbench code using  
 ```
 gvim tb_good_mux.v -o good_mux.v  
 ```
 <img width="958" alt="mux code n tb" src="https://user-images.githubusercontent.com/114488271/204545185-254d6e7e-fcac-4e29-9390-392feea36609.png">
 
 ## Introduction to yosys and Logic Synthesis
 
**Synthesizer** :It is a tool used for the conversion of an RTL to a netlist.  
**Netlist**: It is a representation of the input design to yosys in terms of standard cells present in the library. Yosys is the Synthesizer tool that we will be using. Diiferent levels of abstraction and synthesis.  

<img width="935" alt="Screenshot_20221129_072106" src="https://user-images.githubusercontent.com/114488271/204547621-488f1822-58e7-42f5-8c89-2d999f901d50.png">

* read_verilog : It is used to read the design
* read_liberty : It is used to read the library .lib
* write_verilog : It is used to write out the netlist

##Labs using yosys and sky130 PDKs
---
commands to synthesise an RTL code(good_mux) are:
```
yosys  
read_liberty -lib ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib  
read_verilog good_mux.v  
synth -top good_mux  
abc -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib  
show  
```
<img width="563" alt="yosys-2" src="https://user-images.githubusercontent.com/114488271/204778287-dd117f7e-512f-4d14-99e5-d7810f8a8490.png">

Note:ABC is the command that converts our RTL file into a gate .What gate it has linked to, that gate is specified in the library with the path ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib .The logic of good mux will be realised through standard cells present in the library of the mentioned path. The execution of ABC command gives us a report of the number of input and the output signals of our standard cell.

<img width="403" alt="yosys-3" src="https://user-images.githubusercontent.com/114488271/204778307-ccb7ea88-4baa-42be-87da-2fc000327154.png">
It also specifies the type and number of cells in a synthesis of RTL design
<img width="544" alt="Screenshot_20221129_020509" src="https://user-images.githubusercontent.com/114488271/204778604-b59fa46e-0e8a-4fe5-aa73-bec13ae7b034.png">
<img width="930" alt="Screenshot_20221129_020539" src="https://user-images.githubusercontent.com/114488271/204778222-2fe73a15-2b0b-40e5-8606-6a89ee9309e6.png">

### Commands to write the netlist
```
write_verilog -noattr good_mux_netlist.v
!gvim good_mux_netlist.v
```  
<img width="612" alt="Screenshot_20221129_020912" src="https://user-images.githubusercontent.com/114488271/204778256-c3cf8dbe-4854-42ce-9876-0813357036e4.png">

-------------------------

## Day-2 Timing Libs, Heirarchial vs Flat Synthesis And Efficient Flop Coding Styles
---- 
### Introduction to Timing.lib
----
The library that is said to have a collection of all the standard cells along with their different flavors. We begin by understanding the name of the library. To look into the library,we use the gvim command  

```
gvim ../lib/SKY130_fd_sc_hd__tt_025C_1v80.lib
```  
<img width="895" alt="Screenshot_20221201_051054" src="https://user-images.githubusercontent.com/114488271/205282702-9e124774-54fa-4576-be04-3b13b8e6cc1f.png">
<img width="731" alt="sub-module synthesis" src="https://user-images.githubusercontent.com/114488271/205282719-8bec0ab3-3778-42d0-b0b9-f6c27d265b42.png">
<img width="809" alt="sync_res" src="https://user-images.githubusercontent.com/114488271/205282728-9bdac5cc-1d56-46a3-b1c5-f1cdbf4dad23.png">
<img width="946" alt="async_res" src="https://user-images.githubusercontent.com/114488271/205282738-e0f646cd-6a3d-45e1-a40f-b1a407a66b62.png">
<img width="875" alt="async_res_implementaion" src="https://user-images.githubusercontent.com/114488271/205282741-ebb0eb31-146c-46ee-ae86-63db8439c2f7.png">
<img width="782" alt="async_set" src="https://user-images.githubusercontent.com/114488271/205282751-d2d90eb6-5686-48a6-8a35-78fe391c86ee.png">
<img width="659" alt="heirarchial_flat-1" src="https://user-images.githubusercontent.com/114488271/205282758-3be1b952-2a93-4087-b7de-bbf896f583a7.png">
<img width="385" alt="heirarchial_flat-2" src="https://user-images.githubusercontent.com/114488271/205282762-3f175401-b812-403e-8d02-c77ce6003cfd.png">
<img width="637" alt="heirarchial_flat-3" src="https://user-images.githubusercontent.com/114488271/205282767-5b677c8c-46f3-4372-affa-5c154bcce670.png">
<img width="867" alt="heirarchial_flat-4" src="https://user-images.githubusercontent.com/114488271/205282772-ee1865e1-dd2c-410a-acac-ebc2eef0c1dc.png">
<img width="811" alt="multiplication RTL codes" src="https://user-images.githubusercontent.com/114488271/205282779-1de15d1f-ce80-40c7-a94e-9298e9e40480.png">
<img width="817" alt="optimisation-1" src="https://user-images.githubusercontent.com/114488271/205282785-d0c0ff71-6c6e-469a-90d5-e6a0912f4a4e.png">
<img width="679" alt="optimisation-2" src="https://user-images.githubusercontent.com/114488271/205282790-a55adc0b-ac1f-48db-8dce-c2969bb7898a.png">
<img width="682" alt="Screenshot_20221201_041101" src="https://user-images.githubusercontent.com/114488271/205282799-c4857ca7-9742-4440-8b20-61a27efa1131.png">
<img width="654" alt="Screenshot_20221201_041614" src="https://user-images.githubusercontent.com/114488271/205282809-b3cf42ec-1c1c-4f47-9d8c-d20b3e0e0dc4.png">
<img width="640" alt="Screenshot_20221201_044836" src="https://user-images.githubusercontent.com/114488271/205282817-d62cafb5-e82a-4985-a38e-081aec0af8d3.png">
<img width="579" alt="Screenshot_20221201_045229" src="https://user-images.githubusercontent.com/114488271/205282828-4b946343-76e8-4dbc-80a6-3480c353a85f.png">
<img width="646" alt="Screenshot_20221201_045315" src="https://user-images.githubusercontent.com/114488271/205282835-cc43743d-95e5-4c62-bf8a-d281a6b09c09.png">
<img width="465" alt="Screenshot_20221201_045806" src="https://user-images.githubusercontent.com/114488271/205282846-e242e495-7cc9-4a1a-b876-db3c9655b080.png">














