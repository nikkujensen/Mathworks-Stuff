function Qi = genGenForces(F,V,varS,varT)

% first decompose the inputs
F = subs(F,varT,varS);      % assert symbolic version
F = formula(F);             % assert sym format
V = subs(V,varT,varS);      % assert symbolic version
V = formula(V);             % assert sym format

% define some common parameters
numGenC  = size(F,2);    % number of generalized coordinates

% define some indices for the vectors
%     k     = 1;          % generalized coordinate
kDot  = 2;          % first deriv
%     kDDot = 3;          % second deriv

% compute F x V for virtual work like result then pull off the
% coefficients for the generalized forces.
dW = sym([]);                           % initialize the dW equation

for i = 1:numGenC
    dW(i) = F(:,i)' * V(:,i);           % form virtual work-ish form
end

Q = simplify(sum(dW));                  % sum all results for full generalized force equation

Qi = equationsToMatrix(Q,varS(:,kDot)); % pull off the coefficients for generalized forces

end