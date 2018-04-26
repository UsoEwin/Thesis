# NEURODETECT
## On-chip Biosignal Computation for Health Mornitoring

## Contributer: Jingbo Wu(JW), Chen Fu(CF), Mary Lee Lawrence(MLL) from [Muller Lab](https://people.eecs.berkeley.edu/~rikky/Home.html)

### Introduction

This repo presents all our hardware subgroup's work. DO NOT try to push to this repo unless you receive permission from JW, CF or MLL. Clone your own piece for further usage.

This repo includes a fully implemented 16 channels seizure detector using iEEG signal in Verilog and related testbenches. See the source code in src folder and testbenches in tb folder.

### Dependency

	*Modelsim for testbench verification (or whatever simulation tool you want)
	*Xilinx ISE 14.7 for synthesizing the code, generating bit files
	*FrontPanel for sending the bit files into XEM 6010 FPGA

### Setup
To clone this repo and swtich to ctrl branch, type following command in your bash or command line(or simply click the download button on this page):
```
git clone https://github.com/UsoEwin/Thesis.git
git fetch
git checkout ctrl
```
