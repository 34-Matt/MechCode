function [x,t] = ImplicitMidpoint(f,t1,t2,h,xi)
    
    %% Setup
    t = t1:h:t2;
    n = length(t);
    if ischar(f)
        f = str2func(f);
    end
    if n <= 1
        error('Decrease time step h to increase iterations')
    elseif n < 3
        fprintf('Function is unable to reach iteration')
    end
    x = zeros(length(xi),n);
    x(:,1) = xi;
    xguess(:,1) = xi;
    %% Iteration
    for i = 2:n
        fguess = f(t(i-1),x(:,i-1));
        xguess = x(:,i-1) + h*fguess;
        fguess = f(t(i-1),0.5*(x(:,i-1)+xguess));
        x(:,i) = x(:,i-1) + h*fguess;
    end
end