function out = getFolders(root)
% example:

%         % create the source path
%         srcDir = strcat(rootDir,"\source");
% 
%         % get all folder paths that are within this root directory
%         folderPaths = getFolders(srcDir);
% 
%         % add them to the current path
%         for fldr = folderPaths
%            addpath(fullfile(srcDir,genpath(fldr)),'-end');      % add the folder to the path tool
%         end

% first run the dir to get all contents
D = dir(root);

% set it up
fnames = strings(1);        % preallocate
k = 0;                      % initialize

% then loop through and print all of the name
for i = 1:numel(D)
    x = D(i);
    
    % remove the current directory "." and parent directory ".." and ".git"
    % file. And, remove the examples folder in case any of these could
    % overlap with other user files that may have similar names
    switch x.name
        case {".", "..",".git","examples"}
            % nothing
        otherwise
            % check if it is a folder type or not
            if isfolder(x.name)
                k = k + 1;               % counter
                fnames(k) = x.name;      % add the folder names to an array
            else
                % nothing
            end
            
    end
    
end

% assign the output
out = fnames;

end