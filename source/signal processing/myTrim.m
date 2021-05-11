function yNew = myTrim(y,N)
% function used to trim data for the chosen block size.
% Typically, a reshape like "reshape(y,N,[])" is followed after.

len  = length(y);               % data length
rmnd = rem(len,N);              % get the remainder
yNew = y(1:len-rmnd);           % get data that can be split up evenly with the given block size

end