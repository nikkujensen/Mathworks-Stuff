function [lambdaOut, sigOut] = beamNonDimCalcs(lam,sig,idxs)
% this function helps calculate the dimensionless parameters for beyond the
% first five mode shapes. The method is adopted from "Formulas for Natural 
% Frequency and Mode Shapes" by Dr. Robert D. Blevins

% get the inputs
lambda = lam;
sigma = sig;

% check if modes requested are higher than the fifth
if max(idxs)>5
    
%     % get the further mode indices
%     numHighModes = max(idxs)-5;
    
    % calculate the values for the higher modes
    for i = 6:max(idxs)
       lambda(i) = (2*i + 1)*pi/2;
       sigma (i) = 1;
    end
    
else
    
    % nothing
    
end

% assign the outputs
lambdaOut = lambda;
sigOut    = sigma;

end