function YCP = myCP(Y1,Y2)
%MYCP This is a function that computes crosspower based on an input and
%output linear spectrum. This function permits blocked data, which should
%have the data running top to bottom and blocks left to right. NOTE: Y1 is
%input data and Y2 is output data. In other words, conj(Y1).*Y2



%% perform the power spectrum calculations
YCP = conj(Y1).*Y2;

end

