# RaspberryPi_FPScope
Fourier ptychographic microscope based on a Raspberry Pi. 

Published as:
Aidukas, T., Eckert, R., Harvey, A.R. et al. Low-cost, sub-micron resolution, wide-field computational microscopy using opensource hardware. Sci Rep 9, 7457 (2019). https://doi.org/10.1038/s41598-019-43845-9

This repository contains an instruction set to build the microscope, CAD files, data acqusition and data processing codes.

DATA_CAPTURE.py:
This file contains a Python script required to obtain images for Fourier ptychography using a Raspberry Pi computer, Raspberry Pi camera and Unicorn HD LED array. These images are obtained by flashing LEDs in a spiral pattern from the center towards the edges.

CAD Files:
This folder contains .scad and .stl formats of all the parts required to 3D print the microscope. Instructions are outlined in the Supplementary material S1 of our paper.

Fourier ptychographic reconstruction code and test data to use with the reconstruction code can be found at: http://dx.doi.org/10.5525/gla.researchdata.594

Download a Raspbian OS SD card image which includes the necessary libraries from:
https://drive.google.com/open?id=1Z59lnhNKuGGGVIF1KtoCw2bAcdZESKBo


