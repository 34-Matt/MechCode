function graph = plotFourier(Cr,freqSet)
    figure('Name','Discrete Fourier');
    
    graph = stem(freqSet,Cr);
    
    title('Frequency Spectrum')
    ylabel('Cr')
    xlabel('Frequency')
end