function [x,t] = IRK(f,t1,t2,h,xi)
    
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
    
    a = [1/4,(1/4)-(sqrt(3)/6);(1/4)+(sqrt(3)/6),1/4];
    b = [1/2,1/2];
    c = [(1/2)+(sqrt(3)/6),(1/2)-(sqrt(3)/6)];
    %% Iteration
    for i = 1:n-1
        k1guess1 = f(t(i)+c(1)*h,x(:,i));
        k2guess1 = f(t(i)+c(2)*h,x(:,i));
        k1guess2 = f(t(i)+c(1)*h,x(:,i) + h*a(1,2)*k2guess1);
        k2guess2 = f(t(i)+c(2)*h,x(:,i) + h*a(2,1)*k1guess1);
        k1 = f(t(i)+c(1)*h,x(:,i) + h*(a(1,1)*k1guess2 + a(1,2)*k2guess2));
        k2 = f(t(i)+c(2)*h,x(:,i) + h*(a(2,1)*k1guess2 + a(2,2)*k2guess2));
        x(:,i+1) = x(:,i) + h*(b(1)*k1 + b(2)*k2);
    end