function genGenCoords(var)
% the purpose of this function is to efficiently generate the variables
% needed for Lagrange derivation of equations of motion. A few highlights
% are below:

% 1. Three variable versions exist: symbolic, program, and time.
% Note: The order the variables are input is the order they will be in
% arrays.

% 2. Arrays are generated for the symbolic, program, and time versions and
% should be used for substitution during the derivation and matlab function
% generation. Symbolic versions are used for defining functions and taking
% partial derivatives WRT generalized coordinates (see LagrangeEq). Program
% versions are used for abbreviated naming when using the matlab function
% generation. Time versions are used for takng derivatives WRT time (see
% LagrangeEq).

% 3. Symbolic versions are assigned in the base workspace to be used for
% defining necessary parts during the derivation.

% 4. Symbolic variables have their time derivatives defined with a "d" or
% multiple "d"'s. For example, x' is xd. And x'' is xdd.

% 5. When visualized, symbolic variables will show up in the LiveScript display with
% dots over whatever is the variable. Two examples: t1 will look like t1
% with a dot over the 1 for its derivative. Whereas, t_1 will have a dot
% over the t and subscript still as 1. These two conditions are addressed
% in the script.

% 6. Program versions are used for substituting when generating matlab
% functions. Because symbolic versions can have some long names to display
% nicely, these versions help create denser variable names as described in
% (4).

% 7. Time versions have their time derivatives defined with use of the diff
% MATLAB command. For example, xd or yd are displayed as diff(x(t),t) and
% diff(y(t),t).

% define some common parameters
t        = sym('t','real');                 % time. used for time version definitions
numGenC  = length(var);                     % number of generalized coordinates

% initialize the arrays that will contain the symbolic, time, and
% program versions of variables. These will be used for
% substitutions.
varS = sym([]);                             % initialize the array
varT = sym([]);                             % initialize the array
varP = sym([]);                             % initialize the array

% loop through the setup for each generalized coordinate
for i = 1:numGenC
    
    q      = var(i);                        % get the current generalized coordinate
    q_strP = string(q);                     % convert name to string
    
    % program string names
    qd_strP = q_strP + "d";                 % create first derivative
    qdd_str = q_strP + "d" + "d";           % create second derivative
    
    % check if the variable has any subscript notation
    spots = strfind(q_strP,"_");            % get positions of underscores
    
    % if there is no subscript notation then proceed with defining the
    % variable display with "var_dot" for time derivatives
    if isempty(spots) == 1
        
        qd_strVis  = q_strP + "_dot";       % visual first derivative
        qdd_strVis = q_strP + "_ddot";      % visual second derivative
        
        % if there are subscripts/underscores, then split up the string to
        % add the dot notation properly
    else
        
        % split the string by its subscripts to put in the corresponding dots
        qd_strVis  = replaceBetween(q_strP,spots(1),spots(1),"_dot_");
        qdd_strVis = replaceBetween(q_strP,spots(1),spots(1),"_ddot_");
        
    end
    
    % create symbolic versions
    qS   = sym(q_strP,'real');
    qdS  = sym(qd_strVis,'real');
    qddS = sym(qdd_strVis,'real');
    
    % create program versions
    qP   = sym(q_strP,'real');
    qdP  = sym(qd_strP,'real');
    qddP = sym(qdd_str,'real');
    
    % convert string (with an "(t)") to a symbolic variable
    qT   = str2sym(q_strP + "(t)");
    
    % define variables of time version as functions of time
    qT   = symfun(qT,t);
    qdT  = diff(qT,t,1);
    qddT = diff(qT,t,2);
    
    assignin('base',q_strP,qS)
    assignin('base',qd_strP,qdS)
    assignin('base',qdd_str,qddS)
    
    % create the variable vectors
    varT = [varT;qT,qdT,qddT];
    varS = [varS;qS,qdS,qddS];
    varP = [varP;qP,qdP,qddP];
    
end

% the time version array is changed here to the sym data type for
% easier use in the code
varT = formula(varT);

% assign the variable vectors to the base workspace
assignin('base','varT',varT)
assignin('base','varS',varS)
assignin('base','varP',varP)

end