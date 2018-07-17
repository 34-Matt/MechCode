function [v1,C] = dischargeOrifice(D,d,p,u,dP,vguess,tol)
    A1 = .25*pi*D^2;
    A2 = .25*pi*d^2;
    B = d/D;
    M = 1/sqrt(1-B^4);
    A = @(RE)
    
    maxCount = 1E3;
    
    if ~exist('tol','var')
        tol = 1E-3;
    end
    
    for i = 1:maxCount
        RE = (p*vguess*D)/u;
        A = (19000*B/RE)^0.8;
        con = 10^6/RE;
        C = 0.5961 + 0.0261*B^2 - 0.216*B^8 + 0.000521*(con*B)^0.7 ...
            + (0.0188+0.0063*A)*(B^3.5)*(con^0.3);
        mdot = p*A2*M*C*sqrt(2*dP/p);
        v1 = mdot/(p*A1);
        if (v1-vguess) < tol
            return
        end
        vguess = v1;
    end
end