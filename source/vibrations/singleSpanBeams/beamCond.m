function [beam, lambda] = beamCond(beam,idxs,cond)
% this function processes the beam boundary conditions and computes
% parameters accordingly. The method is adopted from "Formulas for Natural 
% Frequency and Mode Shapes" by Dr. Robert D. Blevins

% check the boundary conditions and assign outputs
switch cond
    case {"Free-Free","Clamped-Clamped"}
        
        %% set the first five nondimensional parameters
        lambda = vpa(...
                    [4.73004074
                    7.85320462
                    10.9956078
                    14.1371655
                    17.2787597]...
                    ,9);            % (null) - higher frequency mode shapes specified with (2*i + 1)*pi/2
        sigma  = vpa(...
                    [0.982502215
                    1.000777312
                    0.999966450
                    1.000001450
                    0.999999937]...
                    ,9);            % (null) - higher frequency mode shapes specified with approx. = 1
                
        %% establish functions for higher mode parameters if necessary
        lamFun = @(i)(2*i + 1)*pi/2;        % set the function handle
        sigFun = @(i)(1);                   % set the function handle
        
        %% establish mode shape functions
        lp1 = lambda(idxs) * beam.x./beam.L;        % common lumped parameter #1
        modeFun = @(sigma)...
                (cosh(lp1) + cos(lp1) - ...
                 sigma.* (sinh(lp1) + sin(lp1)));   % (null) normalized mode shapes
        
    case {"Clamped-Free"}
        
        %% set the first five nondimensional parameters
        lambda = vpa(...
                    [1.87510407
                    4.69409113
                    7.85475744
                    10.99554073
                    14.13716839]...
                    ,9);            % (null) - higher frequency mode shapes specified with (2*i + 1)*pi/2
        sigma  = vpa(...
                    [0.734095514
                    1.018467319
                    0.999224497
                    1.000033553
                    0.999998550]...
                    ,9);            % (null) - higher frequency mode shapes specified with approx. = 1
                
        %% establish functions for higher mode parameters if necessary
        lamFun = @(i)(2*i - 1)*pi/2;        % set the function handle
        sigFun = @(i)(1);                   % set the function handle
        
        %% establish mode shape functions
        lp1 = lambda(idxs) * beam.x./beam.L;        % common lumped parameter #1
        modeFun = @(sigma)...
                (cosh(lp1) - cos(lp1) - ...
                 sigma.* (sinh(lp1) - sin(lp1)));   % (null) normalized mode shapes             
        
    otherwise
        
        error("Please choose an appropriate set of boundary conditions")
        
end
        
%% calculate higher modes if necessary
if max(idxs)>5
    
    % find the first index higher than 5
    idx = find(idxs>5);
    
    for i = idx
        lambda(i) = lamFun(i);
        sigma (i) = sigFun(i);
    end
    
end
    
%% calculate the mode shapes
beam.modes = modeFun(sigma(idxs));

end