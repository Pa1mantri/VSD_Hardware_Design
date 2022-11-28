# VSD Hardware Design Flow
-------------------------------------------------------
# Day 0
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

##Tool : **ngspice**

Installation source:
(https://sourceforge.net/projects/ngspice/files/ng-spice-rework/38/ )

Installation guide:
(https://github.com/ngspice/ngspice/blob/master/INSTALL ) #Install from tarball

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



