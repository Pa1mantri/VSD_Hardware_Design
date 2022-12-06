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
The following window appears that shows the library file SKY130_fd_sc_hd__tt_025C_1v80.lib

<img width="682" alt="Screenshot_20221201_041101" src="https://user-images.githubusercontent.com/114488271/205282799-c4857ca7-9742-4440-8b20-61a27efa1131.png">

First line is the name of the library where TT stands for typical. For a design to work three parameters of the library are important :

*.P- Process:Process is the variations due to fabrication
*.V -voltage: Variations in voltage also impact the behavior of the circuit.
*.T- temperature :Semiconductors are very sensitive to temperature variations too. All this variations determine the performance of a silicon whether it is fast or slow. Thus, our libraries are characterized to model this variations. The voltage process and temperature conditions are also specified.

Switching off the syntax color red  
```
syn off  
```  
<img width="654" alt="Screenshot_20221201_041614" src="https://user-images.githubusercontent.com/114488271/205282809-b3cf42ec-1c1c-4f47-9d8c-d20b3e0e0dc4.png">

The lib contains different flavors of this same as well as different types of cells.

<img width="640" alt="Screenshot_20221201_044836" src="https://user-images.githubusercontent.com/114488271/205282817-d62cafb5-e82a-4985-a38e-081aec0af8d3.png">
<img width="579" alt="Screenshot_20221201_045229" src="https://user-images.githubusercontent.com/114488271/205282828-4b946343-76e8-4dbc-80a6-3480c353a85f.png">

As we see in the above window,
The library also represents the different features of the cell like its leakage power,the various input's combinations and the operations between them.

We pick a small gate small gate for better understanding. We see it's behaviour view.

<img width="465" alt="Screenshot_20221201_045806" src="https://user-images.githubusercontent.com/114488271/205282846-e242e495-7cc9-4a1a-b876-db3c9655b080.png">

We can see in the GVIM window above that there are two input for And gate, and thus four possible combinations the leakage power and the logic levels of which are specified. We now perform the comparison between the and gates.

<img width="895" alt="Screenshot_20221201_051054" src="https://user-images.githubusercontent.com/114488271/205282702-9e124774-54fa-4576-be04-3b13b8e6cc1f.png">

On comparison we see that the and gate "and2_4" has more area as compared to the and gate "and2_2" which in turn has more area with the and gate "and2_0". It is thus evident that and2_4 employs wider transistors. These are the different flavours of the same and gate. And and2_4 being the widest also has large leakage power values as well as large area. But it will have small delay values as it is faster.

### HEIRARCHIAL VS FLAT SYNTHESIS  
----
While syntheisizing the RTL design in which multiple modules are present, the synthesis can be done in two forms.

<img width="659" alt="heirarchial_flat-1" src="https://user-images.githubusercontent.com/114488271/205282758-3be1b952-2a93-4087-b7de-bbf896f583a7.png">

It has two some moduels. The module 1 is an OR gate ,sub module 2 is AND gate. The sub module called multiple modules instantiates sub module 1 as u1 and sub module 2 as u2. It has three inputs a b c and an output y.

<img width="385" alt="heirarchial_flat-2" src="https://user-images.githubusercontent.com/114488271/205282762-3f175401-b812-403e-8d02-c77ce6003cfd.png">

The report has inferred submodule1 having one AND gate ,submodule2 to having one OR gate and multiple module having two cells . Now we link this design to the library using abc command. To show the graphical version ,we use the command.
```  
show multiple_modules  
```  

<img width="637" alt="heirarchial_flat-3" src="https://user-images.githubusercontent.com/114488271/205282767-5b677c8c-46f3-4372-affa-5c154bcce670.png">

Instead of or and and gates it shows the instances u1 and u2 while preserving the hierarchy. This is called the hierarchical design.

Instead of or, and the circuit is implemented using nand and inverter gates. We always prefer stacked NMOS's(nand gates)to stacked the PMOS's(nor cascaded with inverter for or). Because pmos has a very poor mobility and therefore they have to be made quite wide to obtain a good logical effort.
When we use flatten to generate a flat netlist. Here there are no instances of U1 and U2 and hierarchy is not present.

<img width="867" alt="heirarchial_flat-4" src="https://user-images.githubusercontent.com/114488271/205282772-ee1865e1-dd2c-410a-acac-ebc2eef0c1dc.png">

### Sub-Module Level Synthesis And Necessity
----
Need for sub-module synthesis

*. Module level synthesis is preferred when we have multiple instances of the same module.
   Let's assume a top module having multiple instances of the same unit gates(say, a multiplier) .Rather than synthesizing multiplier multiple times as 
   mult1,mult2,mult3, It's better to synthesise it once and replicate it multiple Times.
*. Divide and conquer approach
   Let's assume our RTL design is very very massive and we are giving it to a tool which is not doing a good job. Instead of giving one massive design to the tool,    we give portions by portions to the tool so that it provides an optimised netlist and we can stitch all these net lists at at the top level.

Hence we control the model that we are synthesizing using the keywords
```
synth -top "sub-module name"
```  
In the following example, I am going to synthesize at sub_module 1 level although I have read the RTL file at higher module level multi_modules.v
```  
read_verilog multiple_modules.v  
synth -top sub_module1
```  
<img width="731" alt="sub-module synthesis" src="https://user-images.githubusercontent.com/114488271/205282719-8bec0ab3-3778-42d0-b0b9-f6c27d265b42.png">

In the synthesis report,it inferring only 1 AND gate.

### Asynchronous And Synchronous Resets 
----  
Asynchronous reset: this reset signal does not wait for a clock .The moment asynchronous reset signal is received output queue becomes 0 irrespective of the clock.

Asynchronous set: this set signal does not wait for a clock. The moment asynchronous reset is signal received output queue becomes 1 irrespective of the clock.  

GTKWAVE RTL Simulation and Observations :

<img width="809" alt="sync_res" src="https://user-images.githubusercontent.com/114488271/205282728-9bdac5cc-1d56-46a3-b1c5-f1cdbf4dad23.png">
<img width="946" alt="async_res" src="https://user-images.githubusercontent.com/114488271/205282738-e0f646cd-6a3d-45e1-a40f-b1a407a66b62.png">
<img width="782" alt="async_set" src="https://user-images.githubusercontent.com/114488271/205282751-d2d90eb6-5686-48a6-8a35-78fe391c86ee.png">

Asynchronous reset Synthesis Implementation results

<img width="875" alt="async_res_implementaion" src="https://user-images.githubusercontent.com/114488271/205282741-ebb0eb31-146c-46ee-ae86-63db8439c2f7.png">

### Optimisations
----  
Let's Consider the following two cases for designs where 
1.3 bit input is multiplied by 2 and the output is a 4 bit value.
2.3 bit input is multiplied by 9 and the output is a 6 bit value.

RTL codes for both the codes can be found below.  

<img width="811" alt="multiplication RTL codes" src="https://user-images.githubusercontent.com/114488271/205282779-1de15d1f-ce80-40c7-a94e-9298e9e40480.png">

The output y[3:0] is the input a[2:0] appended with a 0 at the LSB. or, we can say that y = aX2 = {a,0} .

On synthesizing the netlist and look at its graphical realisation , we will see the same optimisation occuring in the netlist.There is no hardware required fot it.

<img width="817" alt="optimisation-1" src="https://user-images.githubusercontent.com/114488271/205282785-d0c0ff71-6c6e-469a-90d5-e6a0912f4a4e.png">

 The output y[5:0] is equal to the input a[2:0] appended with itself 

<img width="679" alt="optimisation-2" src="https://user-images.githubusercontent.com/114488271/205282790-a55adc0b-ac1f-48db-8dce-c2969bb7898a.png">

## Day-3 : Combinational and Sequential optimisations
----
### Introduction to logic optimisations
----
Inorder to produce a digital circuit design which is optimised interms of area and power, the simulator performs many types of optimisations on the combinational and sequential circuits.  















