function [x,t] = AdamBash3(f,t1,t2,h,xi)
    
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
    f1 = f(t(1),x(:,1));
    x(:,2) = x(:,1) + h * f1;
    %% AdamBash2 for second step
    f0 = f(t(2),x(:,2));
    x(:,3) = x(:,2) + h * (1.5*f0 - 0.5*f1);
    %% Iteration
    for count = 3:(n-1)
        f2 = f1;
        f1 = f0;
        f0 = f(t(count),x(:,count));
        x(:,count+1) = x(:,count) + h/12 * (23*f0 - 16*f1 + 5*f2);
    end
end