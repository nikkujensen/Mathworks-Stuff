function lambda = beamLambda(cond,i)
% this function calculates the lambda dimensionless parameter for mode 
% shapes. The method is adopted from "Formulas for Natural Frequency and 
% Mode Shapes" by Dr. Robert D. Blevins
% Input options
%       Free-Free
%       Clamped-Clamped

% get the boundary conditions and pick the dimensionless equations
switch cond
    
    case {"Free-Free","Clamped-Clamped"}
        
        syms lambda sig
        eqLam = cos(lambda)*cosh(lambda) == 1;
        eqSig = (cosh(lambda)-cos(lambda))/(sinh(lambda) - sin(lambda));
        
        initGuess = [4 8 11 14 17];     % guess above to get higher accuracy
        
    otherwise
        
        error("Please choose an appropriate set of boundary conditions")
        
end


end