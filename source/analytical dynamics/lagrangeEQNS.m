function [MM,FF] = lagrangeEQNS(Lag,Pi,Qi,varDEQ,varS,varT)

% define some common parameters
t        = sym('t','real');                 % time. used for time version definitions
numGenC  = size(varDEQ,1);                  % number of generalized coordinates

% first decompose the inputs
Lag = subs(Lag,varT,varS);  % assert the Lagrangian as symbolic first
Lag = simplify(Lag);        % simplify the expression
Lag = formula(Lag);         % assert sym format

% extract the generalized force coefficients
jj = 1;                             % initialize
Q_coeffs = sym(zeros(size(Qi)));    % initialize
for Q = Qi.'
    % get the coeff
    if Qi(jj) ~= sym(0)
        Q_coeffs(jj) = coeffs(Qi(jj),varS(jj,2));
    else
        Q_coeffs(jj) = 0;
    end
    
    % counter
    jj = jj + 1;
end

% define some indices for the vectors
k     = 1;          % generalized coordinate
kDot  = 2;          % first deriv
kDDot = 3;          % second deriv

% now for the meat of the computations. Compute Lagrange's equation
eq = sym([]);           % initialize the equations

for i = 1:numGenC
    dL_dqdot    = diff(Lag,varDEQ(i,kDot));     % partial WRT qdot
    dL_dqdot    = subs(dL_dqdot,varS,varT);     % subs for time deriv next
    dL_dqdot_dt = diff(dL_dqdot,t);             % diff WRT time
    dL_dqdot_dt = subs(dL_dqdot_dt,varT,varS);  % subs for symbolic version
    dL_dq       = diff(Lag,varDEQ(i,k));        % partial WRT q
    dP_dqdot    = diff(Pi,varDEQ(i,kDot));      % partial WRT qdot
    
    % assign the equation
    eq(i) = dL_dqdot_dt - dL_dq + dP_dqdot;
    
end

% form the whole equation with generalized forces
eq = simplify(expand(eq));      % simplify the expression
eq = subs(eq,varT,varS);        % make sure time versions are subs
[MM,FF] = equationsToMatrix(eq(:) == Q_coeffs(:),varDEQ(:,kDDot));

end