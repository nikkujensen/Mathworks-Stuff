function beamOut = beamModes(beam,i,cond)
% this function calculate mode shapes and natural frequencies of a
% single-span beam subject to various boundary conditions. The method
% is adopted from "Formulas for Natural Frequency and Mode Shapes" by Dr.
% Robert D. Blevins
% Input options
%       beam must include the following structure:
%           beam.E: modulus of elasticity (Pa)
%           beam.L: beam length (m)
%           beam.I: area moment of inertia (m^4)
%           beam.m: mass per unit length (kg/m) - Hint: rho * A
%           beam.n: number of discretization points (null)
%       index must be an integer or vector of integers. For instance
%           i = 1
%           i = [1 3 7]
%           i = [1:10]
%       boundary conditions must be one of the following.
%           Free-Free
%           Clamped-Clamped

% dimensionless constants for mode shapes
[lambda, sigma] = beamNonDim(cond,i);

% calculate discretization point locations
beam.x = linspace(0,beam.L,beam.n);

% calculate frequencies
f = double(...
    lambda(i).^2/...
    (2*pi*beam.L^2) * sqrt(beam.E*beam.I./beam.m)...
            );                                      % (Hz)
omg = 2*pi*f;                                       % (rad/s)

% calculate the mode shapes based on the boundary conditions
beamModeShapes(beam,lambda,sigma,cond);

% assign outputs
beamOut = beam;
beamOut.wn = omg;
beamOut.fn = f;
beamOut.Tn = 1./f;

end