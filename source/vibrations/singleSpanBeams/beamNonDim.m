function [lambdaOut, sigOut] = beamNonDim(cond,idxs)
% this function calculates the dimensionless parameters for up to the
% first five mode shapes. The method is adopted from "Formulas for Natural 
% Frequency and Mode Shapes" by Dr. Robert D. Blevins
% Input options
%       Free-Free
%       Clamped-Clamped

% get the boundary conditions and pick the dimensionless values
switch cond
    
    case {"Free-Free","Clamped-Clamped"}
        
        lambda = vpa(...
                 [4.73004074
                  7.85320462
                  10.9956078
                  14.1371655
                  17.2787597]...
                           ,9);     % (null) - higher frequency mode shapes specified with (2*i + 1)*pi/2
        sig    = vpa(...
                 [0.982502215
                  1.000777312
                  0.999966450
                  1.000001450
                  0.999999937]...
                           ,9);     % (null) - higher frequency mode shapes specified with approx. = 1
        
    otherwise
        
        error("Please choose an appropriate set of boundary conditions")
        
end

% calculate higher mode parameters if necessary
[lambda, sig] = beamNonDimCalcs(lambda,sig,idxs);

% assign the outputs
lambdaOut = lambda(idxs);
sigOut    = sig(idxs);

end