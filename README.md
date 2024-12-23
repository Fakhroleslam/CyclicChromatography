# CyclicChromatography
This repository contains the simulation code for the paper "Cyclic Chromatography Processes as Hybrid Systems: Dynamic Simulation and Optimal Design for 5-HMF/Water Separation" published in the Journal of Water Process Engineering.

# Overview
This project explores a two-bed, four-step cyclic chromatography process, conceptualized as a hybrid system incorporating continuous and discrete states. The study focuses on the separation of 5-HMF from water. A novel hybrid model was developed and implemented using MATLAB s-functions and Stateflow® Chart in MATLAB/Simulink®. The simulator was validated with experimental breakthrough data, demonstrating excellent accuracy.

The cyclic chromatography process involves four steps:
1. ADS (Adsorption): The feed undergoes adsorption to remove impurities, resulting in a high-purity product.
2. DES (Desorption): Adsorbed materials are released from the adsorption bed.
3. RIN (Rinsing): The column is rinsed with a solvent to remove remaining impurities and solvents.
4. STB (Standby): The bed is regenerated and prepared for the next cycle.

# Technical Details
•  ODE model: The ordinary differential equations (ODEs) were solved using MATLAB/Simulink®’s ode15s solver, which employs a variable-step, variable-order method based on numerical differentiation formulas.

•  Discrete-Event System model: The discrete-event behavior of the process was modeled using a Stateflow® Chart in MATLAB/Simulink®.

Open-source examples of the developed simulator can be found in this repository and in Supplementary Materials attached to the paper.
