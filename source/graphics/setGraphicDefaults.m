% this script is for setting personal defaults regarding graphics options
% for the current MATLAB session

% A helpful article <https://www.mathworks.com/help/matlab/creating_plots/default-property-values.html 
% here> regarding the default settings for graphics objects. And <https://www.mathworks.com/help/matlab/graphics-objects.html 
% here> is the locations for the graphics objects in MATLAB.

% global params
FS = 12;                                            % font size
FW = "bold";                                        % font weight
INTERP = "latex";                                   % interpreter
CLRORDR = [1 0 0;0 0 1;0 1 0;0 0 0;1 0 1;0 1 1];    % color order ('r','b','g','k','m','c')
LSORDR  = ["-","--","-.",":"];                      % line style order
LW = 1.5;                                             % line width
% LEGLOC = "best";                                    % legend location

% axes settings
set(0,"defaultAxesFontSize",FS)
set(0,"defaultAxesFontWeight",FW)
set(0,"defaultAxesTickLabelInterpreter",INTERP)
set(0,"defaultAxesColorOrder",CLRORDR)
set(0,"defaultAxesLineStyleOrder",LSORDR)

% line settings
set(0,"defaultLineLineWidth",LW)

% legend settings
set(0,"defaultLegendInterpreter",INTERP)
% set(0,"defaultLegendLocation",LEGLOC)


% other settings
set(0,"defaultTextInterpreter",INTERP)              % this modifies the interpreter for figure titles