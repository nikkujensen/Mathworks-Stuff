function beamModesPlot(beam)
% this function is used to plot beam mode shapes following execution of
% "beamModes"

% loop through all beam modes
h = struct([]);                                                 % initialize for speed
for i = 1:size(beam.modes,1)
    
    h(i).fig = figure;                                          % create a figure
    h(i).ln = line(beam.x./beam.L,beam.modes(i,:));             % plot the mode shape
    h(i).tlStr = strcat("Mode ",string(beam.idx(i)),": ",...
        string(beam.fn(i)), " [Hz], ",...
        string(2*pi*beam.fn(i)), " [rad/s]");                   % create figure title
    h(i).tl = title(h(i).tlStr);                                % generate title
    h(i).xlb = xlabel("$\frac{x}{L}$","Interpreter","latex");               % x-label
    h(i).ylb = ylabel("$\tilde{y}(\frac{x}{L})$","Interpreter","latex");    % y-label
    grid on                                                     % turn on grid
    
    % more formatting
    h(i).ln.Marker = "*";
end

end