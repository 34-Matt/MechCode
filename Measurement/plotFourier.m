function graph = plotFourier(Cr,freqSet)
%plotFourier Creates a phase chart for the Fourier transform
%   INPUT:
%       Cr The array of coefficient for the Fourier terms
%       freqSet The array of frequency responses for each coefficient
%   OUTPUT:
%       graph The formated phase diagram
    %%
    % Create new figure
    figure('Name','Discrete Fourier');
    %%
    % Plot Graph
    graph = stem(freqSet,Cr);
    %%
    % Lable Graph
    title('Frequency Spectrum')
    ylabel('Cr')
    xlabel('Frequency')
end