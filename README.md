# NEURODETECT
## On-chip Biosignal Computation for Health Mornitoring

## Contributer: Jingbo Wu(JW), Chen Fu(CF), Mary Lee Lawrence(MLL)

### Introduction

This repo presents all our hardware subgroup's work. DO NOT try to push to this repo unless you receive permission from JW, CF or MLL. Clone your own piece for further usage.

This repo includes a fully implemented 16 channels seizure detector using iEEG signal in Verilog and detailed testbenches. See the source code in src folder and testbenches in tb folder.

### Dependency

	*Modelsim for testbench verification (or whatever simulation tool you want)
	*Xilinx ISE 14.7 for synthesizing the code, generating bit files
	*FrontPanel for sending the bit files into XEM 6010 FPGA

### How to train
```
python main.py
```

if you want to see the flag 
```
python main.py -h
```

### How to test

If you don't input a Test image, it will be default image
```
python main.py --is_train False
```
then result will put in the result directory


If you want to Test your own iamge

use `test_img` flag

```
python main.py --is_train False --test_img Train/t20.bmp
```

then result image also put in the result directory

## References

   [tegg89/SRCNN-Tensorflow](https://github.com/tegg89/SRCNN-Tensorflow)
