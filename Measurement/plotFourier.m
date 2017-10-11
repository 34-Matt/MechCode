function graph = plotFourier(Cr,freqSet)
%plotFourier Creates a phase chart for the Fourier transform
%   INPUT:
%       Cr The array of coefficient for the Fourier terms
%       freqSet The array of frequency responses for each coefficient
%   OUTPUT:
%       graph The formated phase diagram

    figure('Name','Discrete Fourier');
    
    graph = stem(freqSet,Cr);
    
    title('Frequency Spectrum')
    ylabel('Cr')
    xlabel('Frequency')
end