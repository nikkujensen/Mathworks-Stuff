function L = setLineDefaults(L)
% this function is for rotating through line colors to allow colorblind to
% tell the difference. Meaning, each line is a different color and style
% until you run out of styles
% Inputs:
%       % L:    line object from the plot command
%       (https://www.mathworks.com/help/matlab/ref/matlab.graphics.chart.primitive.line-properties.html)

% get the number of default colors
clrs = size(get(0,"defaultAxesColorOrder"),1);

% loop through all the lines to set their color and style
ct = 1;             % counter
for ln = L'
    ln.SeriesIndex = ct;
    ct = ct + clrs + 1;
end