**VSD Hardware Design Flow**



  * [Day-0 <strong>Tool Installations</strong>](#day-0-tool-installations)

* [Day -1  Introduction to verilog RTL design and Synthesis](#day--1--introduction-to-verilog-rtl-design-and-synthesis)

   * [<strong>Introduction to opensource simulator iverilog</strong>](#introduction-to-opensource-simulator-iverilog)

   * [<strong>Labs using iverilog and gtkwave</strong>](#labs-using-iverilog-and-gtkwave)

   * [<strong>Labs using yosys and sky130 PDKs</strong>](#labs-using-yosys-and-sky130-pdks)

* [Day-2 Timing Libs, Heirarchial vs Flat Synthesis And Efficient Flop Coding Styles](#day-2-timing-libs-heirarchial-vs-flat-synthesis-and-efficient-flop-coding-styles)

   * [<em><strong>Introduction to Timing.lib</strong></em>](#introduction-to-timinglib)

   * [<em><strong>HEIRARCHIAL VS FLAT SYNTHESIS</strong></em>](#heirarchial-vs-flat-synthesis)

   * [<strong>Sub-Module Level Synthesis And Necessity</strong>](#sub-module-level-synthesis-and-necessity)

   * [<em><strong>Asynchronous And Synchronous Resets</strong></em>](#asynchronous-and-synchronous-resets)

      * [Optimisations](#optimisations)

* [Day-3 : Combinational and Sequential optimisations](#day-3--combinational-and-sequential-optimisations)

   * [<em><strong>Introduction to logic optimisations</strong></em>](#introduction-to-logic-optimisations)

   * [<strong>Combinational Logic Optimisations</strong>](#combinational-logic-optimisations)

   * [<strong>Sequential Logic Optimisations</strong>](#sequential-logic-optimisations)

* [Day-4  Gate level simulations, Non blocking and blocking assignments, Synthesis-Simulation mismatch](#day-4--gate-level-simulations-non-blocking-and-blocking-assignments-synthesis-simulation-mismatch)

   * [<em><strong>Introduction to gate level simulations</strong></em>](#introduction-to-gate-level-simulations)

   * [Synthesis Simulaiton mismatches](#synthesis-simulaiton-mismatches)

   * [<em><strong>Labs on GLS and Synthesis-Simulation mismatch</strong></em>](#labs-on-gls-and-synthesis-simulation-mismatch)

* [Day-5 if,case,for loop and for generate](#day-5-ifcasefor-loop-and-for-generate)

   * [<strong>if construct</strong>](#if-construct)

   * [<em><strong>Labs on incorrect IF and case constructs</strong></em>](#labs-on-incorrect-if-and-case-constructs)

   * [<strong>Introduction to Looping constructs</strong>](#introduction-to-looping-constructs)


-------------------------------------------------------
# Day-0 **Tool Installations**
-------------------------------------------------------
Environment: Windows-11 and Ubuntu-22.04
Tool: ***Yosys***

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


Tool: ***OpenSTA***  

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


Tool : ***ngspice***

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

# Day -1  Introduction to verilog RTL design and Synthesis
-------------------------------------------------------------
**Introduction to opensource simulator iverilog**
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
 
 **Introduction to yosys and Logic Synthesis**
 
**Synthesizer** :It is a tool used for the conversion of an RTL to a netlist.  
**Netlist**: It is a representation of the input design to yosys in terms of standard cells present in the library. Yosys is the Synthesizer tool that we will be using. Diiferent levels of abstraction and synthesis.  

<img width="935" alt="Screenshot_20221129_072106" src="https://user-images.githubusercontent.com/114488271/204547621-488f1822-58e7-42f5-8c89-2d999f901d50.png">

* read_verilog : It is used to read the design
* read_liberty : It is used to read the library .lib
* write_verilog : It is used to write out the netlist

**Labs using yosys and sky130 PDKs**
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

***Commands to write the netlist***
```
write_verilog -noattr good_mux_netlist.v
!gvim good_mux_netlist.v
```  
<img width="612" alt="Screenshot_20221129_020912" src="https://user-images.githubusercontent.com/114488271/204778256-c3cf8dbe-4854-42ce-9876-0813357036e4.png">

-------------------------

# Day-2 Timing Libs, Heirarchial vs Flat Synthesis And Efficient Flop Coding Styles
---- 
***Introduction to Timing.lib***
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

***HEIRARCHIAL VS FLAT SYNTHESIS*** 
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

***Sub-Module Level Synthesis And Necessity***
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

***Asynchronous And Synchronous Resets*** 
----  
Asynchronous reset: this reset signal does not wait for a clock .The moment asynchronous reset signal is received output queue becomes 0 irrespective of the clock.

Asynchronous set: this set signal does not wait for a clock. The moment asynchronous reset is signal received output queue becomes 1 irrespective of the clock.  

GTKWAVE RTL Simulation and Observations :

<img width="809" alt="sync_res" src="https://user-images.githubusercontent.com/114488271/205282728-9bdac5cc-1d56-46a3-b1c5-f1cdbf4dad23.png">
<img width="946" alt="async_res" src="https://user-images.githubusercontent.com/114488271/205282738-e0f646cd-6a3d-45e1-a40f-b1a407a66b62.png">
<img width="782" alt="async_set" src="https://user-images.githubusercontent.com/114488271/205282751-d2d90eb6-5686-48a6-8a35-78fe391c86ee.png">

Asynchronous reset Synthesis Implementation results

<img width="875" alt="async_res_implementaion" src="https://user-images.githubusercontent.com/114488271/205282741-ebb0eb31-146c-46ee-ae86-63db8439c2f7.png">


***Optimisations***
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

# Day-3 : Combinational and Sequential optimisations
----
***Introduction to logic optimisations***
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


# Day-4  Gate level simulations, Non blocking and blocking assignments, Synthesis-Simulation mismatch
---
***Introduction to gate level simulations***  
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

***Labs on GLS and Synthesis-Simulation mismatch***
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

# Day-5 if,case,for loop and for generate
---

**if construct**
---

If condition is used to to write priority logic. The condition one has a priority or if has more priority than the consecutive else statements . Only when condition 1 is not met condition 2 is evaluated and so on and y is assigned accordingly depending on the matching conditions. So,If-Else code translates to a ladder like multiplexer structure in the final design instead of a single multiplexer.

**Incomplete if statements** infers a latch.

```
if(condition1)
y=a;
else if(condition 2)
y=b;
```

In the above code if condition 1 is matched y is equal to a else if condition 2 is matched y is equal to b but there is no specification for the case when condition2 is not matched, as a result of which the simulator tries to latch this case to the output y.It wants to retain the value of y.
This is a combinational loop to avoid that the simulator infers a latch. Enable of this latch is OR of the condition 1 and condition 2. If neither condition 1 or condition 2 is met the OR gate output disables the latch . The latch retains the value of y and stores it.
This is called the inferred latch due to incomplete if statements which is very dangerous for RTL designing. It should be avoided except for some special cases like the counter.

```
reg [2:0] count;
always@(posedge clk)
begin
if(reset)
count <=3'b000;
else if(enable)
count <= count+1;
end
```
This is also a case of incomplete if statements. Here ,if there is no enable the counter should latch onto the previous value.For example if the counter has counted up till 4 and there is no enable then it should retain the value 4 rather than going to 0 again.
So here the incomplete if statements result in latching And retaining the previous value which is our desired behavior in a counter. The earlier mux example was a combinational circuit and therefore we cannot have inferred latches.

Note:
If, case statements are used inside always block.
In verilog whatever variable we use to assign in if or case statements must be a register variable.


**case construct**

```
always@(*)
begin
case(sel)
    2'b00: y= statement1;
    2'b01: y= statement2;
    2'b10: y= statement3;
    2'b11: y= statement4;
endcase
end
```
The case statements do not infer priority logic like IF statements. Depending upon the case matching the y is assigned accordingly.

Some caveats with using CASE statements:

* Incomplete case
* Partial assignments
* Overlapping cases

**Incomplete Cases**

```
reg [1:0] sel;
always@(*)
begin
    case(sel)
    2'b00: condition 1;
    2'b01: condition 2;
   endcase
end

```

If select is 10 or 11 the conditions are not specified. It causes an incomplete case which results in inferred latches for these two cases that latch on to output y.This occurs when some cases are not specified inside the CASE block .For example, if the 2'b10 and 2'b11 cases were not mentioned , the tool would synthesize inferred latches at the 3rd and 4th inputs of the multiplexer.
Solution is to code the case block with default inside the CASE block so that the tool knows what to do when a case that is not specified occurs.
    

```
reg [1:0] sel;
always@(*)
begin
    case(sel)
    2'b00: condition 1;
    2'b01: condition 2;
    default:condition 3;
   endcase
end

```

**Partial Assignments**

```
reg [1:0] sel;
always@(*)
begin
    case(sel)
    2'b00: begin
            x = a;
            y = b;
            end
    2'b01: begin 
            x = c;
            end
    default: begin 
            x = d;
            y = d;
            end
   endcase
end

```
In the above example, we have 2 outputs x and y. This will create two 4X1 multiplexers with the respective outputs. If we look at case 2'b01, we have specified the value of x for this case ,but not the value of y. It appears that it is okay to do so, as a default case is specified for both the outputs, and if we don't directly specify the value of y for any case, the simulator will implement the default case. This, however , is incorrect. In partial assignments such as this, the simulator will infer a latch at the 2nd input for multiplexer y as no value is specified for a particular case.

**Overlapping case**


```
reg [1:0] sel;
always@(*)
begin
    case(sel)
    2'b00: begin
            x = a;
            end
    2'b01: begin 
            x = b;
            end
     2'b10: begin 
            x = c;
            end
     2'b1?: begin 
            x = d;
            end
   endcase
end

```

In the above code block ,2'b1? specifies that the corresponding bit can be either be 0 or 1. This means when the sel input is holding a value 3 i.e 2'b11, cases 3 and 4 both hold true. What is synthesized depends on the mercy of the simulator. It can lead to Synthesis-Simulation mismatches.
If we used an IF condition here, due to priority logic, condition 4 would be ignored when condition 3 is met. However,in the CASE statement , even if the upper case is matched,all the cases are checked.So,if there is overlapping in cases,it poses a problem as the cases are not mutually exclusive. And we would get an unpredictable output.

***Labs on incorrect IF and case constructs*** 
---

Below are the files titled incomp_if.v, incomp_if2.v and can be found in the directory verilog_files.

<img width="731" alt="Screenshot_20221205_102737" src="https://user-images.githubusercontent.com/114488271/206408357-c826100d-ae68-41cb-9c5d-5230caf11ab1.png">

The code incomp_if.v contains an incomplete IF statement as no else condition corresponding to it is mentioned . On simulating this design , following gtkwave is obtained

<img width="929" alt="Screenshot_20221205_102942" src="https://user-images.githubusercontent.com/114488271/206408360-607d2566-7bd9-411b-8863-9b465336401e.png">

From the above waveform, We observe no change in y when i0=0.It's equal to previous value when io=0. This shows latching Action, which is verified by looking at the synthesis implementation using Ysosys. A D-latch is created in the synthesised netlist.

<img width="851" alt="Screenshot_20221205_104237" src="https://user-images.githubusercontent.com/114488271/206408375-c37f6e11-a349-4faa-9f4f-149c91152c5b.png">

The code in incomp_if2.v  contains an incomplete IF statement as well. Here, we have 2 inputs i1 and i3, as well as 2 conditional inputs i0 and i2. As we do not specifythe case when both i0 and i2 go low,which results in an issue in the synthesis. The gtkwaveform of the simulated design is below

<img width="896" alt="Screenshot_20221205_105050" src="https://user-images.githubusercontent.com/114488271/206408386-218067ac-4199-4ae8-931d-fada6077f433.png">

Observation: When io is high,output follows i1. When io is low,it looks for i2.If i2 is high,it follows i3. But if i2 is low(and io is already low),y attains a constant value that is previous output.

This can be verified by checking the graphical realisation of the yosys synthesis below.

<img width="873" alt="Screenshot_20221205_105342" src="https://user-images.githubusercontent.com/114488271/206408399-a15f5b7f-aa20-49a0-89cf-9d6ea9f7e778.png">

Yosys synthesizes a multiplexer as well as a latch with some combinational logic at its enable pin.

Below are the codes for incomp_case.v, comp_case.v

<img width="771" alt="Screenshot_20221205_011958" src="https://user-images.githubusercontent.com/114488271/206408165-748e8b4f-27d2-4aa3-8727-a4e98f455516.png">

Whenever se[1]=1 ,latching action takes place. The yosys synthesis implementation is given below.

<img width="916" alt="Screenshot_20221205_011918" src="https://user-images.githubusercontent.com/114488271/206408160-bc80b143-12f2-4f2a-b5f3-2a834454c1a6.png">

Observation: 1. (sel[1]) is going to D latch enable. 2.The inputs io,sel[0], !(sel[1]) go to the upper mixing logic that is implemented on D pin of the latch.

In comp_case.v code Output follows i2 at default case,if i1 and io go low. Hence a 4X1 mux is synthesized without any latch that can be verified below.

<img width="925" alt="Screenshot_20221205_012308" src="https://user-images.githubusercontent.com/114488271/206408185-b902d1de-05e6-441a-ab34-6188031834a0.png">

**Partial assignments**

<img width="854" alt="Screenshot_20221205_012558" src="https://user-images.githubusercontent.com/114488271/206408188-ff81bc83-e0ae-405d-80da-334e38c2b957.png">

The 2X1 mux with output y is inferred without any latch. The second output x will infer a latch. Below image shows the statistics of the gates and latches it infers

<img width="482" alt="Screenshot_20221205_013451" src="https://user-images.githubusercontent.com/114488271/206408192-4065ecd5-c086-417d-867f-5689f97f4646.png">

4:1 mux with overlapping case:

<img width="834" alt="Screenshot_20221205_015430" src="https://user-images.githubusercontent.com/114488271/206408197-f406e733-fffc-4565-86fd-918541657464.png">

In gtkwaveform of RTL simulation:

<img width="926" alt="Screenshot_20221205_015849" src="https://user-images.githubusercontent.com/114488271/206408203-3e26024c-f6a9-4a81-bce7-9504a7e1f279.png">

Observation : When sel[1:0]=11, the output neither follows i2 nor i3. It simply latches to 1.

Whereas while running GLS on the netlist,the waveform of the synthesized netlist behaves as 4X1 mux as shown below

<img width="897" alt="Screenshot_20221205_020910" src="https://user-images.githubusercontent.com/114488271/206408210-38e8bc81-c354-403f-b82f-4693f1f7c429.png">

Thus ,Overlapping cases confuse the simulator and leads to Synthesis-Simulation Mismatches.

**Introduction to Looping constructs**
---

There are two types of FOR loops in verilog.

* For loop used in always block used to evaluate expressions.
* Generate for loop only used outside the always block, used for instantiating hardware.

For loops are extremely useful when we want to write a code /design that involves multiple assignments or evaluations within the always block. Lets us take an example, If we want to write the code for 4:1 multiplexer, we can easily do so using a either four if blocks or using a case block with 4 cases,as seen in the previous if-else blocks.But this approach is not suitable for complicated design with numerous inputs/outputs say 256X1 mux.If we wanted to design a 256X1 multiplexer, we will have to write 256 lines of condition statements using select and corresponding assignments. But in for loop ,be it 4X1 or 256X1 we would always be writing 4 lines of code only. Although we need to provide 256 inputs using an internal bus.

```
integer k;
always@(*)
begin
for(k=0;k<256;k=k+1)
begin
if(k==sel)
y=in[k];
end
end
```
This code can be infinitely scaled up by just replacing the condition k < 256 with the desired specification for our multiplexer.

Similarly, we can create High input demultiplexers as well.

```
integer k;
always@(*)
begin
int_bus[15:0] = 16'b0;
for(k=0;k<16;k=k+1)
begin
if(k==sel)
int_bus[k]=inp[k];
end
end
```
Here , we have created a 16:1 demultiplexer using for loops within the always block. The int_bus[15:0] specifies our internal bus which takes on the input of the demux. It is necessary to assign all outputs to low for a new value of sel else latches will be inferred resulting in the incorrect implementation of our logic.

mux_generate.v that generates a 4X1 mux using For loop.

<img width="611" alt="Screenshot_20221205_034433" src="https://user-images.githubusercontent.com/114488271/206408259-b217c285-ece1-4f4b-b1eb-e0b42e38720e.png">

The gtkwave obtained after the simulation

<img width="887" alt="Screenshot_20221205_033829" src="https://user-images.githubusercontent.com/114488271/206408232-15da724b-fad4-4bec-9a0b-7e3a786083ef.png">

demux_generate.v that generates a 4X1 demux using For loop.

<img width="736" alt="Screenshot_20221205_035547" src="https://user-images.githubusercontent.com/114488271/206408267-f6083172-bc77-426d-8f67-a2e49eeee880.png">

The above code has good readabilty,scalability and easy to write as well. Let's verify if it functions as a 8X1 demux as expected by viewing its gtkwave simulated waveform.

<img width="806" alt="Screenshot_20221205_041550" src="https://user-images.githubusercontent.com/114488271/206408300-6cb2d99c-e9f9-41d6-b729-67e0f00f92b5.png">


**for generate**

FOR Generate is used when we needto create multiple instances of the same hardware. We must use the For generate outside the always block.

We take example of a 8 bit Ripple Carry Adder(RCA) to understand the ease of instantiations provided by the For generate statement. An RCA consists of Full Adders tied in series where the carry out of the previous full adder is fed as the carry in bit of the next full adder in the chain. Hence, we can make use of generate for to instantiate every full adder in the design , as they are all represent the same hardware.

For this example , we use the file rcs.v which holds the code for the ripple carry adder. It also needs to be included in our simulation. Here, fa references another verilog design file containing the definition of all the full adder submodules .This is shown below, from the fa.v file

<img width="865" alt="Screenshot_20221205_051042" src="https://user-images.githubusercontent.com/114488271/206408333-fa291834-3bf6-4101-b5e4-255cc3d33416.png">

In the RCA verilog code, we instantiate fa in a loop using generate for outside the always block.

Now, let us simulate this design in verilog and view its waveform with GKTWave .As the rca design referances the file fa.v , we must specify it in our commands as follows

```
iverilog fa.v rca.v tb_rca.v
./a.out
gtkwave tb_rca.v
```
the resulting gtkwaveform is shown below that shows an adder being simulated:

<img width="894" alt="Screenshot_20221205_052051" src="https://user-images.githubusercontent.com/114488271/206408343-70f596fd-3d6a-4924-80d5-f3b7d93082eb.png">



# Day-7 Timing and constraints fundamentals
----
**what are constraints?**

A RTL code can be synthesized in multiple ways using the standard cells present. A constraint file guides the synthesizer to select the appropriate library cells to meet the timing and performance requirements

**what is SDC?**

SDC stands for Synopsys Design Constraints which has become an industry standard for various design tools to specify the design constraints to enable appropriate optimisation suitable for acheiving the best implementation during synthesis.

During synthesis a constraint file is provided along with the RTL and .lib to help the synthesis tool decide what flavour of the cell to use to optimize the design for performance and area.

<img width="652" alt="Screenshot_20230209_111441" src="https://user-images.githubusercontent.com/114488271/217742867-4512500d-eb48-4692-8b12-962f7b1a4a2c.png">


***Static timing analysis***

* Setup Time Requirement(Max Delay)
 
 Time required to meet the setup time of the clock. 
 
 <img width="162" alt="Screenshot_20230209_124122" src="https://user-images.githubusercontent.com/114488271/217742862-b69051b2-968e-4075-a0d4-aac7750d5f6a.png">
 
 Let say the design runs at 200MHZ i.e; Tclk = 5ns so the maximum combinational delay must be TCOMBI < 5-TCQA-Tsetup_B.
 
* Hold Time Requirement(Min Delay)
 
 Time required to meet the hold time requirement of the flop.

<img width="461" alt="Screenshot_20230209_124109" src="https://user-images.githubusercontent.com/114488271/217742871-fa14d200-057b-4850-8f23-6b3464b322d1.png">

This defines the constraints given by the HOLD window and this occurs usually when we delay the clock (with delay circuits in red) so we can meet a fixed COMBI delay with a slower clock (e.g TCOMBI = 8ns , Tclk=5ns)
THOLD_B+ TPUSH < TCQ_A+TCOMBI ; TPUSH is the time inserted by the delay circuits.

Parameters affecting the delay

* Higher inflow of current(input transition) corresponds to lower delay.
* Higher load capacitance(output load) higher the delay.

----

***Timing Arcs***

For a COMBINATIONAL CELL, delay information from every input pin to output pin which it can control is present in timing arc.

For a SEQUENTIAL CELL

* Delay from clk to Q for DFlop
* Delay from clk to Q or D to Q for Dlatch
* Setup and Hold times

<img width="883" alt="Screenshot_20230105_050118" src="https://user-images.githubusercontent.com/114488271/217742919-d62aa58f-1010-4af4-a8ac-afc48da9b2bb.png">








