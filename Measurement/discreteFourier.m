function [Cr,theta,fundamentalFreq,freqSet] = discreteFourier(sample, sampleRate)
    N = length(sample);
    if (rem(N,2) ~= 0)
        sample = sample(end-1);
        N = length(sample);
    elseif (N == 0)
        error("There is nothing in the sample array")
        return
    end
    
    T = N * sampleRate;
    fundamentalFreq = 1/T;
    
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
    
    Cr2 = Ar.^2 + Br.^2;
    Cr = Cr2.^.5;
    
    theta(1,:) = atan(Ar./Br);
    theta(2,:) = atan(Br./Ar);
end