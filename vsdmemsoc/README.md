

##  VSDMEMSOC
---
VSDMemSoC is a small SOC which includes RISC-V based processor RVMYTH and and external SRAM.

First we need a clone this repository

```
$ cd
$ https://github.com/vsdip/VSDMemSoC
```

Pre-synthesis Simulation can be done using the following commands

```
$ cd VSDMemSoC
$ make pre_synth_sim
```

This will create two files pre_synth_sim.out and pre_synth_sim.vcd in the pre_synth_sim folder.(output folder)

> gtkwave pre_synth_sim.vcd 

the above commands gives the waveforms of the design pre-synthesis.

For the post synthesis simulation we use OpenLane.

OpenLane installation

```
$ git clone https://github.com/The-OpenROAD-Project/OpenLane.git
$ cd OpenLane/
$ make openlane
$ make pdk
$ make test
```

First step in the design flow is to synthesize the generated RTL code and after that we will simulate the result.
This way we can find more about our code and its bugs. 
So in this section we are going to synthesize our code then do a post-synthesis simulation to look for any issues. 
The post and pre (modeling section) synthesis results should be identical.

To perform synthesis use the following command

```
$ cd ~/VSDMemSoC
$ make synth
```
The above command results in synth.log and vsdmemsoc.synth.v files.
vsdmemsoc.synth.v is the netlsit file generated using the given libraries. All the commands needed to generate a netlist file are under one script file.

List of commands used in the script

```
read_verilog -I./include ./module/vsdmemsoc.v

read_verilog -I./include ./module/controller.v

read_verilog -I./include ./module/clk_gate.v

read_verilog -I./include ../output/compiled_tlv/rvmyth.v

read_liberty -lib ./lib/sky130_fd_sc_hd__tt_025C_1v80.lib

read_liberty -lib ./lib/sram_32_256_sky130A_TT_1p8V_25C.lib

synth -top vsdmemsoc

dfflibmap -liberty ./lib/sky130_fd_sc_hd__tt_025C_1v80.lib

opt

abc -liberty ./lib/sky130_fd_sc_hd__tt_025C_1v80.lib -script +strash;scorr;ifraig;retime;{D};strash;dch,-f;map,-M,1,{D}

flatten

setundef -zero

clean -purge

rename -enumerate

stat

write_verilog -noattr ../output/synth/vsdmemsoc.synth.v
```

This will create two files post_synth_sim.out and post_synth_sim.vcd in the post_synth_sim folder.(output folder)

>gtkwave post_synth_sim.vcd

The above command gives the waveform post synthesis.

Images of both pre and post synthesis simualtion of the desing:


<img width="937" alt="Screenshot_20221221_051846" src="https://user-images.githubusercontent.com/114488271/209082036-172dd7b5-c3ba-406f-aab7-8213b355f373.png">
<img width="960" alt="Screenshot_20221222_115342" src="https://user-images.githubusercontent.com/114488271/209082095-15772e6e-aa8e-463b-b0e6-18c00993703f.png">





