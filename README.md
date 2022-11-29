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

## Day -1 ** Introduction to verilog RTL design and Synthesis**
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



