function [x,t] = AdamBash2(f,t1,t2,h,xi)
    
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
    %% Euler for first step
    f0 = f(t(1),x(:,1));
    x(:,2) = x(:,1) + h * f0;
    %% Iteration
    for count = 2:(n-1)
        f1 = f0;
        f0 = f(t(count),x(:,count));
        x(:,count+1) = x(:,count) + h * (1.5*f0 - 0.5*f1);
    end
end