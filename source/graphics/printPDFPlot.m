function printPDFPlot(h) % input a figure. output a figure and use the print command
% this is used to print a pdf of a figure that is cropped to its minimum
% size for use in documents say written in Latex
% Requirements:
		% - the figure object must have the following two properties
			% 1. h.fig
			% 2. h.filename
			
% Example code
% if cPrint == 1
    % for i = 1:length(h)
        % fig = printPDFPlot(h(i).fig);
        % figPath = "figures\";                           % set the path for saving
        % figFullname = strcat(figPath,h(i).filename);    % create the full filename
        % print(fig,figFullname,'-dpdf')
    % end
% end

% get the input and loop if necessary
for i = 1:length(h)
    fig = printPDF(h(i).fig);
    figPath = "figures\";                           % set the path for saving
    figFullname = strcat(figPath,h(i).filename);    % create the full filename
    print(fig,figFullname,'-dpdf')
end

    function fig = printPDF(h)
        % graphics processing for good look
        set(h,'Units','Inches');
        pos = get(h,'Position');
        set(h,'PaperPositionMode','Auto','PaperUnits','Inches', ...
            'PaperSize',[pos(3), pos(4)])
        
        % assign the fig
        fig = h;
    end

end