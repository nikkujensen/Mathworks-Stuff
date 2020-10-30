% this script is for removing personal defaults regarding graphics options
% for the current MATLAB session

% get the current defaults and their names
setts = get(0,"default");
nms   = fieldnames(setts)';

% skip the first standard ones
nms = nms(6:end);

% loop through each field and set back to default
for nm = nms
   set(0,string(nm),'remove')
end
