function [x,t,xguess] = AdamMoulton4AB3(f,t1,t2,h,xi)
    
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
    %% Trapezoidal for first step
    f2 = f(t(1),x(:,1));
    xguess(:,2) = x(:,1) + h * f2;
    fguess = f(t(2),xguess(:,2));
    x(:,2) = x(:,1) + 0.5*h*(fguess + f2);
    f1 = f(t(2),x(:,2));
    %% Adam Moulton 3 for second step
    xguess(:,3) = x(:,2) + h*(1.5*f1 - 0.5*f2);
    fguess = f(t(3),xguess(:,3));
    x(:,3) = x(:,2) + (h/12)*(5*fguess + 8*f1 - f2);
    f0 = f(t(3),x(:,3));
    %% Iteration
    for count = 4:n
        f3 = f2;
        f2 = f1;
        f1 = f0;
        xguess(:,count) = x(:,count-1) + (h/12)*(23*f1 - 16*f2 + 5*f3);
        fguess = f(t(count),xguess(:,count));
        x(:,count) = x(:,count-1) + (h/24)*(9*fguess + 19*f1 - 5*f2 + f3);
        f0 = f(t(count),x(:,count));
    end
end