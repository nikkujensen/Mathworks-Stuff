function printPDFPlot(h)
% this function takes a structure of figures and prints them to PDFs. Note:
% the figures need to be open for this function to work properly.
%
% This is used to print a pdf of a figure that is cropped to its minimum
% size for use in documents say written in LaTeX
% Requirements:
		% - the figure object must have the following two properties
			% 1. h.fig
			% 2. h.filename
% Options:
        % - optional fields to be used for print sizing/scaling
            % 1. h.size  ([width height]) % default in inches
            % 2. h.width ( width )        % default in inches. Note: size
            % overrides width
			
% Example code
% if flags.pdfPrint
%     % print all the figures. Note: they must be open still
%     printPDFPlot(dat.h) 
% end

% get the input and loop if necessary
for i = 1:length(h)
    
    % toggle visibility so the user isn't jarred with figure changes
    h(i).fig.Visible = "off";
    pos0 = h(i).fig.Position;       % get the original position
    unts0 = h(i).fig.Units;         % get the original units
    
    % proceed
    hTemp = printPDF(h(i));
    figPath = "figures\";                           % set the path for saving
    figFullname = strcat(figPath,hTemp.filename);   % create the full filename
    exportgraphics(hTemp.fig,strcat(figFullname,".pdf"),...
        "ContentType","vector");                    % export the fig with tight margins and embedded fonts
    
    % return to original fig position and toggle visibility
    h(i).fig.Units = unts0;
    h(i).fig.Position = pos0;
    h(i).fig.PaperSize = [pos0(end-1), pos0(end)];
    h(i).fig.Visible = "on";
    
end

    function hOut = printPDF(h)
        % do the processing for a desired look
        h.fig.Units = "Inches";                     % set the units
        
        % check if the export size is specified
        if isfield(h,'size')
            pos = h.size;                           % get the size of the figure
        elseif isfield(h,'width')
            pos = h.width*[1 3/4];                  % use a 4:3 aspect ratio based on desired width
        else
            pos = h.fig.Position;                   % get the size of the figure
        end
        
        % scale the figure to the export size
        h.fig.Position = [0 0 pos(end-1), pos(end)];% set the position on the paper
        h.fig.PaperSize = [pos(end-1), pos(end)];   % set the paper size
        
        % assign the graphic
        hOut = h;
    end

end