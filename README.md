# Example-2-16-Astrom

## System Identification using RLS Algorithm
In this analysis, we aim to identify the parameters of a system described by the equation:

y(t) = 0.8 * y(t - 1) + 0.5 * u(t - 1) + Noise(t);

using the Recursive Least Squares (RLS) algorithm. The RLS algorithm is a widely used method for online estimation of system parameters from input-output data.

## Algorithm Parameters
We will use the RLS algorithm with different forgetting factors (\(\lambda\)) to investigate its impact on parameter estimation accuracy and convergence speed. The forgetting factor controls the influence of past data on the current estimate, with higher values giving more weight to recent data.

- Forgetting Factor (\(\lambda\)):
  - 1.0 (No Forgetting)
  - 0.999
  - 0.99
  - 0.95
 
    ## Implementation
    - MATLAB
   
## System Identification using RLS,SA,PA and LMS
In this analysis, we aim to identify the parameters of a system described by the equation:

y(t) = 0.8 * y(t - 1) + 0.5 * u(t - 1) + Noise(t);

   ### Implementation
  - MATLAB

