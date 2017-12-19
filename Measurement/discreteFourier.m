function [harmonicCoef,theta,fundamentalFreq,nyquist,freqSet] = discreteFourier(sample, sampleRate)
%discreteFourier This function takes samples and sampling rate to create
%the Fourier Series
%   INPUT:
%       sample The array of data points from the measurand
%       sampleRate The time between measurements (units of seconds)
%   OUTPUT:
%       harmonicCoef The coefficients of the Fourier Series with row 1
%       being Ar, row 2 being Br, and row 3 being Cr
%       theta The phase difference between the two terms with row 1 being
%       Ar/Br and row 2 being Br/Ar (units of radians)
%       fundamentalFreq The smallest frequency of the sample (units of Hz)
%       nyquist The nyquist frequency of the sample (units of Hz)
%       freqSet Array of fundamentalFreq time r (units of Hz)
    %%
    % Determine if sample needs to be made even
    N = length(sample);
    if (rem(N,2) ~= 0)
        sample = sample(1:end-1);
        N = length(sample);
    elseif (N == 0)
        error("There is nothing in the sample array")
        return
    end
    %%
    % Determine frequencies
    T = N * sampleRate;
    fundamentalFreq = 1/T;
    nyquist = 1/(2*sampleRate);
    %%
    % Determine Ar and Br
    Ar = zeros(1,N/2+1);
    Br = Ar;
    freqSet = zeros(1,N/2+1);
    
    for r = 0:(N/2)
        for n = 1:N
            Ar(r+1) = Ar(r+1) + (sample(n) * cos(2*r*pi()*n/N));
            Br(r+1) = Br(r+1) + (sample(n) * sin(2*r*pi()*n/N));
        end
        Ar(r+1) = Ar(r+1) * 2 / N;
        Br(r+1) = Br(r+1) * 2 / N;
        freqSet(r+1) = r/T;
    end
    %%
    % Calculate Cr
    Cr2 = Ar.^2 + Br.^2;
    Cr = Cr2.^.5;
    %%
    % Store coefficients
    harmonicCoef(1,:) = Ar;
    harmonicCoef(2,:) = Br;
    harmonicCoef(3,:) = Cr;
    %%
    % Calculate phases
    Ar = abs(Ar);
    Br = abs(Br);
    theta(1,:) = atan(Ar./Br);
    theta(2,:) = atan(Br./Ar);
end