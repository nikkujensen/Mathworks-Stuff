function beamOut = beamModes(beam,i)
% this function calculate mode shapes and natural frequencies of a
% single-span beam subject to "Free-Free" boundary conditions. The method
% is adopted from "Formulas for Natural Frequency and Mode Shapes" by Dr.
% Robert D. Blevins

% dimensionless constants for mode shapes
lambda = [4.73004074, 7.85320462, ...
    10.9956078, 14.1371655, 17.2787597]';           % (null) - higher frequency mode shapes specified with (2*i + 1)*pi/2
sigma  = [0.982502215, 1.000777312,...
    0.999966450, 1.000001450, 0.999999937]';        % (null) - higher frequency mode shapes specified with approx. = 1

% calculate frequencies
f = lambda(i).^2/...
    (2*pi*beam.L^2) * sqrt(beam.E*beam.I./beam.m);  % (Hz)
omg = 2*pi*f;                                       % (rad/s)

% calculate mode shapes
lp = lambda * beam.x./beam.L;                       % lumped parameter
ModeShapes = cosh(lp) + cos(lp) - ...
                  sigma .* (sinh(lp) + sin(lp));    % (null)    normalized mode shapes

% assign outputs
beamOut = beam;
beamOut.wn = omg;
beamOut.fn = f;
beamOut.Tn = 1./f;
beamOut.modes = ModeShapes;

end