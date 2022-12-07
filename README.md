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

## Labs using yosys and sky130 PDKs
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

* P- Process:Process is the variations due to fabrication..  
* V -voltage: Variations in voltage also impact the behavior of the circuit.  
* T- temperature :Semiconductors are very sensitive to temperature variations too. All this variations determine the performance of a silicon whether it is fast or slow. Thus, our libraries are characterized to model this variations. The voltage process and temperature conditions are also specified.

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

1. Combinational Optimisation Methods
  * Squeezing the logic to get the optimised design
     * Area and Power savings  
  * Constant Propogation  
     * Direct Optimisation  
  * Boolean Logic Optimisation
     * K-map
     * Quine-mckluskey Algorithm
     
2. Sequential optimisation methods  
  
  * Basic
     * Sequential Constant Propogation
  * Advanced
     * State Optimisation
        * Retiming
        * Sequential Logic Cloning
        
 **Combinational Logic Optimisations**
 ---
 
We will try to understand each of the above mentioned combinational optimisations through different RTL code examples. We also check the synthesis implementation through yosys to understand how the optimisations take place.
All the optimisation examples are in files opt_check.v,opt_check2.v,opt_check_3.v opt_check4.v,counter.v and multiple_modules_opt.v. All of these files are present under the verilog_files directory.

Below image shows the RTL code for some of the examples mentioned above  

<img width="710" alt="opt_0_1_2_3_4" src="https://user-images.githubusercontent.com/114488271/205887079-55fd2b1e-57c9-443b-8223-b508b39d0a6a.png">

IN the code for opt_check, ideally the above ternary operator should give us a mux. But the constant 0 propagates further in the logic .Using boolean simplification we obtain y = ab.  

Synthesizing this in yosys :

Before realising the netlist, we must issue a command to yosys to perform optimisations. It removes all unused cells and wires to prduce optimised digital circuit.This can be done using the opt_clean -purge command as shown below.

<img width="499" alt="and_statistics" src="https://user-images.githubusercontent.com/114488271/205886889-d0d65906-283d-4ba0-a51c-7f5af97f7a9f.png">

Observation : After executing synth -top opt_check ,we see in the report that 1 AND gate has been inferred.

Next,
```
abc -liberty ../lib/sky130_fd_sc_hd_tt_025C_1v80.lib  
write_verilog -noattr opt_check_netlist.v  
show  
```
On viewing the graphical synthesis realisation , we can see the Yosys has synthesized an AND gate as expected.  
<img width="922" alt="and_gate" src="https://user-images.githubusercontent.com/114488271/205886871-fa93e60f-6be2-4179-8e11-9b2cf30fb28b.png">

For opt_check2 yosys synthesis results in an or gate.
<img width="900" alt="or_gate" src="https://user-images.githubusercontent.com/114488271/205887082-093595ab-15b7-4051-a639-a8d4a9d380f1.png">

For the RTL verilog code of opt_check3.v , we expect the output to be a 3 input AND gate based on constant propagation and boolean logic optimisation.The output y can be simplified to y = abc.
Next we generate the netlist and observe its graphical representation after synthesis  
<img width="936" alt="and_3input" src="https://user-images.githubusercontent.com/114488271/205887110-03b55794-07e4-4ee5-9741-934d4f9b9007.png">
Yosys synthesizes a 3 input AND gate as expected because of optimisations.

For opt_check4.v,the boolean logic optimisation simplifies the output to a single xnor gate i.e. y = a xnor c. Next we generate the netlist and observe its graphical representation after synthesis.  
<img width="853" alt="xnor" src="https://user-images.githubusercontent.com/114488271/205887096-aa4e3909-8a15-4aff-a870-359b806f03e1.png">
Yosys synthesizes a 3 input XNOR gate as expected because of optimisations.

In the image below we can find the codes for multiple_module_opt.v and multiple_module_opt2.v

While synthesizing this in yosys we use flatten before opt_clean -purge. The multiple_module_opt instantiates both submodule1 and 2. We must use Flat Synthesis here otherwise the optimisations will not be performed on the sub module level.

<img width="938" alt="multiple_module_opt" src="https://user-images.githubusercontent.com/114488271/205887053-7100868e-6aab-41a9-b9c6-dee07cfc42ac.png">

For multiple_module_opt2.v on boolean optimisation, we obtain y=1 simply. It's synthesis yields

<img width="895" alt="multiple_module_opt2" src="https://user-images.githubusercontent.com/114488271/205887068-80e84189-3675-45b7-b510-dbf2b36c0689.png">

**Sequential Logic Optimisations**
---  

We will try to understand each of the sequential optimisations through different RTL code examples. For each example, We also check the synthesis implementation through yosys to understand how the optimisations take place.
All the optimisation examples are in files dff_coonst1.v,dff_const2.v,dff_const3.v,dffconst4.v and dff_const5.v,counter_opt.v and counter_opt2.v. All of these files are under the verilog_files directory.

<img width="824" alt="dff_1_2" src="https://user-images.githubusercontent.com/114488271/205886910-51e981c5-a735-49cc-bf63-dca64f8d05b6.png">
<img width="650" alt="dff_3_4_5" src="https://user-images.githubusercontent.com/114488271/205886914-f8d31fb3-5817-4214-ad6b-5a2ecba1156c.png">
 
In the code dff_const1.v, it appears that the output Q should be equal to an inverted reset or Q=!reset. However, as the reset is synchronous,even if the flop has D pinned to logic 1,when reset becomes 0, Q does not immediately goto 1. It waits untill the positive edge of the next clock cycle.
This is observed by simulating the design in verilog, and viewing the VCD with GTKWave as follows
<img width="926" alt="dff_const1_gtk" src="https://user-images.githubusercontent.com/114488271/205886972-a3805fd5-c0b3-4c4a-9f1e-cab0a9068b7e.png">

Observation : In the gtk waveform above , when reset becomes 0, Q becomes 1 at the next clock edge. Since Q can be either 1 or 0,we do not get a sequential constant, and no optimisations should be possible here. We verify it using Yosys synthesis and optimisation.
While synthesis,We use
```
difflibmap -liberty ../lib/sky130_fd_sc_hd_tt_025C_1v80.lib
```  
dfflibmap is a switch that tells the synthesizer about the library to pick sequential circuits( mainly Dff's and latches) from.

We then generate the netlist

```
abc -liberty ../lib/sky130_fd_sc_hd_tt_025C_1v80.lib  
write_verilog -noattr dff_const1_netlist.v  
show  
```
<img width="922" alt="dff_const1_block" src="https://user-images.githubusercontent.com/114488271/205886961-7d62b18c-cab4-4c69-8f23-b79597c97f77.png"> 

As expected, No optimisation is performed in th yosys implementation during synthesis.

In dff_const2.v, regardless of the inputs, the output q always remains constant at 1 .
This is observed by simulating the design in verilog, and viewing the VCD with GTKWave as follows  
<img width="909" alt="dff_const2_gtk" src="https://user-images.githubusercontent.com/114488271/205886985-331d5af2-43c9-40af-b523-60e34b54c1b8.png">

Since the output is always constant ie Q=1, it can easily be optimised during synthesis.

<img width="827" alt="upload at line 343" src="https://user-images.githubusercontent.com/114488271/206062968-c7ea5507-c4c1-4222-bff2-1252eab8e377.png">


In dff_cosnt3.v ,when reset goes from 1 to 0,Q1 follows D at the next positive clock edge in an ideal ckt. But in reality, Q1 becomes 1 a little after the next positive clk edge(once reset has been made 0)due to Clock-to-Q delay.
Thus, q takes the value 0 until the next clock edge when it read an input of 1 from q1. This is confirmed with the simulated waveform below.  
<img width="926" alt="dff_const3_gtk" src="https://user-images.githubusercontent.com/114488271/205887015-fa25b644-e1aa-4686-afe9-93f84f305d1c.png">

Since Q takes both logic 0 and 1 values in different clock cycles. It is wrong to say that Q=!(reset) or Q=Q1
Hence, both the flip-flops are retained and no optimisations are performed on this design. We can confirm this using Yosys as shown below.
<img width="926" alt="dff_const3_block" src="https://user-images.githubusercontent.com/114488271/205886994-1ccb9533-adfa-4702-8ffb-44d607ea1f98.png">

Both the D flip-flops are present in the synthesized netlist.

In dff_const4.v, regardless of the input whether reset or not , Q1 is always going to be constant i.e. Q1=1 . As q can only be 1 or q1 depending on the reset input, but q1 = 1 .Thus q is also constant at the value 1. We can confirm this with the simulated waveforms as shown below.
<img width="907" alt="dff_const4_gtk" src="https://user-images.githubusercontent.com/114488271/205887028-933cc752-e038-4d43-8c98-d90563d7229b.png">

As the output is always constant, it can easily be optimised using Yosys as shown in the graphical representation.  
<img width="888" alt="dff_4_block" src="https://user-images.githubusercontent.com/114488271/205886927-4128a3ec-a8b7-43d6-b1b2-e1f11b3f7204.png">

In the image below, codes of both counter_opt.v and counter_opt2.v are present.
<img width="613" alt="counter" src="https://user-images.githubusercontent.com/114488271/205886893-daf41f58-36bb-42e8-ba08-5e34278e4399.png">

<img width="434" alt="counter_stats" src="https://user-images.githubusercontent.com/114488271/205886900-f4f46be8-ee53-43c7-a789-861eaffa2487.png">

Synthesised ouput of counter_opt2.v
<img width="939" alt="counter_synthesis" src="https://user-images.githubusercontent.com/114488271/205886905-8cf7d4d4-2659-42c3-b66b-16869da0c60b.png">


## Day-4  Gate level simulations, Non blocking and blocking assignments, Synthesis-Simulation mismatch
---
### Introduction to gate level simulations  
---
We validate our RTL design by providing stimulus to the testbench and check whether it meets our specifications earlier we were running the test bench with the RTL code as our design under test .
But now under GLS ,we apply netlist to the testbench as design under test . What We did at the behavioral level in the RTL code got transformed to the net list in terms of the standard cells present in the library. So,netlist is logically same as the RTL code. They both have the same inputs and outputs so the netlist should seamlessly fit in the place of the RTL code. We put the netlist in place of the RTL file and run the simulation with the test bench.
When we do simulation in with the help of RTL code there is no concept of timing analysis such as the hold and setup time which are critical for a circuit. For meeting this setup and hold time criteria there are different flavours of cell in the library.  

<img width="886" alt="Screenshot_20221207_063403" src="https://user-images.githubusercontent.com/114488271/206062920-f0da6741-cdf8-40db-a4a9-afc84ca3843e.png">


In GLS using iverilog flow, the design is a netlist which is given to Iverilog simulator in terms of standard cells present in the library. The library has different flavours of the same type of cell available.To make the simulator understand the specification of the different annotations of the cell the GATE level verilog models is also given as an input. If the GATE level models are timing aware (delay annotated ),then we can use the GLS for timing validation as well.

 >The reason for the functional validation of netlist eventhough the netlist is the true representation of the RTL code is "Synthesis-Simulation mismatch."
 
 Synthesis Simulaiton mismatches
 ---
 * Missing sensitivity list  
 * Blocking and Non-Blocking statements
 
 **Missing sensitivity list**
Simulator functions on the basis of input change. If there is no change in the inputs the simulator won't evaluate the output at all.  

Below image shows the codes of multiplexers in different ways. The codes are for ternary_operator_mux.v,bad_mux.v and good_mux.v

<img width="803" alt="Screenshot_20221204_065205" src="https://user-images.githubusercontent.com/114488271/205918717-de1231f9-bba6-4df2-8d36-3c9dce13de69.png">

The problem in the bad_mux code is that simulation happens only when the select is high so if select is slow and there are changes in i0 or i1 they get completely missed. So for the simulator this marks as good as a latch but the synthesizer does not look at the sensitivity list it checks at the functionality and creates a mux. 
>Simulation infers a latch and Synthesis results in a mux Hence,Mismatch.

Blocking and Non-blocking statements inside an always block.

* Blocking Executes the statements in the order it is written So the first statement is evaluated before the second statement.
* Non Blocking Executes all the RHS when always block is entered and assigns to LHS. Parallel evaluation.  

Blocking assignments:

<img width="619" alt="Screenshot_20221207_063659" src="https://user-images.githubusercontent.com/114488271/206062917-0f63dbca-5df0-442f-9da3-02c63c007f01.png">

In this case, D is assigned to Qo  which is then assigned to Q. Due to optimisation a single latch is formed where Q is equal to D.  

Non-blocking assignments:

```
begin
q0<=d;
q1<=q0;
end
```
In the non blocking assignments all the RHS are evaluated and parallel assigned to lhs irrespective of the order in which they appear. So we will always get a two flop shift register.

Therefore we always use non blocking statements for writing sequential circuits.

Example:

<img width="624" alt="Screenshot_20221207_063825" src="https://user-images.githubusercontent.com/114488271/206062918-2edc1c57-9c1d-4dc2-8a34-5d2c4c5ac280.png">

We enter into the loop whenever any of the inputs a b or C changes but Y is assigned with old Qo value since it is using the value of the previous Tclk ,the simulator mimics a delay or a flop. Where as, during synthesis we see the the OR and AND gates as expected.

Therefore ,while using blocking statements in this case,we should evaluate Q0 first and then Y so that Y takes on the updated values of Qo. Although both the circuits on synthesis give the same digital circuit comprising of AND, OR gates. But on simulation we get different behaviours.

### Labs on GLS and Synthesis-Simulation mismatch
---

<img width="803" alt="Screenshot_20221204_065205" src="https://user-images.githubusercontent.com/114488271/205918717-de1231f9-bba6-4df2-8d36-3c9dce13de69.png">

Simulation of the ternary_operator_mux.v using design as UUT is below.
 
<img width="921" alt="Screenshot_20221204_065752" src="https://user-images.githubusercontent.com/114488271/205918589-93b6cc2e-5154-4a12-bbb9-c66e11e94605.png">

Synthesis of the ternary_operator_mux.v is

<img width="886" alt="Screenshot_20221204_070633" src="https://user-images.githubusercontent.com/114488271/205918601-6e0b1234-cc71-41fd-badc-d406c62dbaf3.png">

To invoke GLS,

* We need to read our netlist file and the test bench file assosciated with it.
* We need to read 2 extra files that contain the description of verilog models in the netlist.
 
>iverilog ../my_lib/verilog_model/primitives.v ../my_lib/verilog_model/sky130_fd_sc_hd.v ternary_operator_mux_net.v tb_ternary_operator_mux.v

<img width="929" alt="Screenshot_20221204_071302" src="https://user-images.githubusercontent.com/114488271/205918612-07bc4241-8f2a-4116-bb10-462dd23d4e2a.png">

To see the waveform of RTL simulation using netlist as UUT ,we execute the following commands further

```
./a.out
gtkwave tb_ternary_operator_mux.v
```
<img width="917" alt="Screenshot_20221204_072115" src="https://user-images.githubusercontent.com/114488271/205918618-9515c0ea-b075-412c-9b81-cd37cb20faf8.png">

RTL codes of bad_mux.v and good_mux.v

<img width="722" alt="Screenshot_20221205_064525" src="https://user-images.githubusercontent.com/114488271/205918641-6eed4726-33d9-46c3-80a5-16d27d40692d.png">

For bad_mux.v the GTK simulation using the testbench and the design gives the following result.

<img width="920" alt="Screenshot_20221205_064707" src="https://user-images.githubusercontent.com/114488271/205918647-f8da1c91-b286-4e45-866a-7b7c0f366d84.png">  

The design simulates a latch rather than a 2x1 mux.But the Yosys implementation shows a 2X1 mux .
If we now implement it's GATE level netlist through GLS and observe the waveform,it shows the behaviour of a 2X1 mux as shown below:

<img width="913" alt="Screenshot_20221205_065245" src="https://user-images.githubusercontent.com/114488271/205918667-c914f41c-fcb6-46d0-9057-4a3994d2399a.png">

Since,the waveforms of stimulated RTL Code : Is of a LATCH the waveforms of gate level netlist thruogh GLS after synthesis: Is of 2X1 MUX We see a Synthesis-Simulation Mismatch.

Example of synthesis-simulation mismatch due to wrong order of assignment in blocking assignments.

<img width="755" alt="Screenshot_20221205_071646" src="https://user-images.githubusercontent.com/114488271/205918714-659db27b-7108-4f24-aa2d-85effa130fda.png">

We enter into the loop whenever any of the inputs a b or C changes but D is assigned with old X value since it is using the value of the previous Tclk ,the simulator mimics a delay or a flop. Where as, during synthesis we see the the OR and AND gates as expected.

<img width="917" alt="Screenshot_20221205_071605" src="https://user-images.githubusercontent.com/114488271/205918706-2f561a51-a354-4080-8718-1959cb3db23b.png">

At the instance where both the inputs a and b are 1. a | b should output 1, which when ANDed with c, should give an output y of 1. The output d thus should hold the value 1. Instead,it holds the value 0 . But due to the blocking statements in the rtl code, it actually holds a the value of a OR b from the previous clock, hence giving us an incorrect output.

The netlist representation on synthesis yields

<img width="929" alt="Screenshot_20221205_070722" src="https://user-images.githubusercontent.com/114488271/205918675-4ec457f3-8e31-437f-847e-5b98a13ba06e.png">

The synthesizer does not see the sensitivity list rather the functionality of the RTL design.Hence,the netlist representation does not include any latches to hold delayed values pertaining to the previous cycle. It only includes an OR 2 AND gate.

If we run gate level simulations on this netlist in verilog, we observe the following waveform.

<img width="912" alt="Screenshot_20221205_071419" src="https://user-images.githubusercontent.com/114488271/205918699-9f1f784a-6d52-42a0-8c43-97b1cd39b2ac.png">

Here , we observe that the circuit behaves as intended combinational ckt. Output d results from the present value of inputs, and not the previous clock values like in the simulation results. Since the waveforms of the stimulated RTL verilog code do not match with the gate level simulation of generated netlist,we get a Synthesis-Simulation Mismatch again.

## Day-5 if,case,for loop and for generate
---

**if construct**
---

If condition is used to to write priority logic. The condition one has a priority or if has more priority than the consecutive else statements . Only when condition 1 is not met condition 2 is evaluated and so on and y is assigned accordingly depending on the matching conditions.















