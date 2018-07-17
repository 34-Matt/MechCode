function [x,t] = Euler(f,t1,t2,h,xi,type)
    
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
    %% Euler Forward
    if isequal(lower(type),'forward')
        for count = 1:(n-1)
            f0 = f(t(count),x(:,count));
            x(:,count+1) = x(:,count) + h * f0;
        end
    end
    %% Euler Backward
    if isequal(lower(type),'backward')
        for count = 1:(n-1)
            f0 = f(t(count),x(:,count));
            xguess = x(:,count) + h * f0;
            f0 = f(t(count),xguess);
            x(:,count+1) = x(:,count) + h * f0;
        end
    end
end