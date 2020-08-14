function beamOut = beamModeShapes(beam,lambda,sigma,cond)
% this function helps calculate mode shapes of a
% single-span beam subject to various boundary conditions. The method
% is adopted from "Formulas for Natural Frequency and Mode Shapes" by Dr.
% Robert D. Blevins

% according to the boundary conditions, calculate the mode shapes
switch cond
    
    case {"Free-Free","Clamped-Clamped"}
        
        lp = lambda * beam.x./beam.L;         % lumped parameter
        ModeShapes = cosh(lp) + cos(lp) - ...
            sigma .* (sinh(lp) + sin(lp));    % (null)    normalized mode shapes
        
    otherwise
        
        % nothing
        
end

% assign outputs
beamOut = beam;
beamOut.modes = ModeShapes;

end