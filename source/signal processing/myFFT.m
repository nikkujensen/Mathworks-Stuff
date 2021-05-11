function  [Y1S, f, Y2] = myFFT(time,sig,win,WCF)
%MY5700FFT Summary of this function goes here
%   Note: the blocks of matrices of data are in the rows and the data is in the
%   columns. Data goes from top to bottom. Blocks go from left to right. 
%   This goes for the time, signal, and window.

%% calculate some parameters based on the inputs
T = time(2,1) - time(1,1);      % (sec)     sampling period
fs = 1/T;                       % (Hz)      sampling frequency
N = size(sig,1);                % (null)    block size
fNyq = fs/2;                    % (Hz)      nyquist frequency

switch WCF
    case "ACF"
        WCF = 1/mean(win);  % amplitude correction factor
    case "ECF"
        WCF = 1/rms(win);   % energy correction factor
end
        
%% check the signal length and determine how much of the double-sided goes to the single-sided spectrum
if ~rem(N,2)
    % even
    len = N/2+1;
	flg = 1;
else
    % odd
    len = N/2+0.5;
	flg = 0;
end

% apply the window before the freq domain
sigW = win.*sig;                % windowed signal

%% calculate the transform
Y2  = fft(sigW);                % matlab fft command - double sided
Y1  = Y2(1:len,:);              % get the single sided

% based on the signal length, determine how to scale (don't double multiply for 0 or fNyq if it is not present on the negative frequency side)
if flg
	Y1S = Y1;                                   % get all the data at first
	Y1S(2:end,:) = 2*Y1S(2:end,:);              % scale the single sided to have full spectrum power and a set period (using N blocks)
else
	Y1S = Y1;                                   % get all the data at first
	Y1S(2:end-1,:) = 2*Y1S(2:end-1,:);          % scale the single sided to have full spectrum power and a set period (using N blocks)
end
Y1S = WCF/N.*Y1S;                               % include DC (0 Hz) in remainder of scaling

f = linspace(0,fNyq,len);       % (Hz)  frequency vector

end

