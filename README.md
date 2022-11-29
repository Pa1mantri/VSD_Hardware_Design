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







