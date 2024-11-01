## Numerical Analysis of Vortex Acoustic Lock-in for combustors

This GitHub repo contains the code and data used for understanding the lock-in phenomenon occurring in combustors of gas turbine engines. This occurs when the fuel-air mixture injected is obstructed by a bluff body (the combustor). A vortex is introduced, which under certain frequencies, equal the vibration acoustic frequency of the combustor. The instant when these frequencies is called acoustic lock-in. This phenomenon is studied to better understand its possible effects on the flow field. 


Here, we model the lock-in phenomenon physics. Following this, we use it to predict the onset of lock-in, in the case of a deterministic, stead flow field within the combustor. This is an ideal case, since the flow is rarely steady in a combustor.

To simulate the real scenario, we introduce turbulence in the flow field. The turbulence is modelled as noise. 

We first start by modelling it as an Additive White Gaussian Noise (AWGN). Following this, we improve the model complexity by representing turbulence as colored noise - stochastic in nature. In other words, we model it as an Ornstein Uhlenbeck Process, and is described as a Stochastic Differential Equation. We solve these different representations using numerical methods on MATLAB. 

We attempt to understand the effect of turbulence on the lock-in phenomenon by generating contour plots, for different values of parameters that define the intensity of the noise (or the correlation factor).

# Additional notes
This work is an extension of the following preliminary work:

Britto AB, Mariappan S. Lock-in phenomenon of vortex shedding in oscillatory flows: an analytical investigation pertaining to combustors. Journal of Fluid Mechanics. 2019 Aug;872:115-46,

and is associated with the Advanced Combustion and Acoustics Lab, Aerospace Engineering
Indian Institute of Technology Kanpur, India. It was done under the guidance of Dr. Sathesh Mariappan.