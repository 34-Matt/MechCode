function [x,t] = RungeKutta2(f,ti,tf,h,xi,alpha)
    
    if ~exist('alpha','var')
        alpha = 2/3;
    end

    c = [0;alpha];
    a = [0,0;alpha,0];
    b = [(1-(1/(2*alpha))),(1/(2*alpha))];
    
    t = ti:h:tf;
    n = length(t);
    x = zeros(length(xi),n);
    
    x(:,1) = xi;
    
    for i = 1:n-1
        k1 = f(t(i),x(:,i));
        k2 = f(t(i)+c(2)*h,x(:,i)+h*a(2,1)*k1);
        x(:,i+1) = x(:,i) + h*(b(1)*k1 + b(2)*k2);
    end
    
end