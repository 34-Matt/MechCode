function [x,t] = RungeKutta4_3_8(f,ti,tf,h,xi)
    
    c = [0;1/3;2/3;1];
    a = [0 0 0 0
        1/3 0 0 0
        -1/3 1 0 0
        1 -1 1 0];
    b = [1/8,3/8,3/8,1/8];
    
    if ischar(f)
        f = str2func(f);
    end
    
    t = ti:h:tf;
    n = length(t);
    x = zeros(length(xi),n);
    
    x(:,1) = xi;
    
    for i = 1:n-1
        k1 = f(t(i),x(:,i));
        k2 = f(t(i)+c(2)*h,x(:,i)+h*a(2,1)*k1);
        k3 = f(t(i)+c(3)*h,x(:,i)+h*(a(3,1)*k1 + a(3,2)*k2));
        k4 = f(t(i)+c(4)*h,x(:,i)+h*(a(4,1)*k1 + a(4,2)*k2 + a(4,3)*k3));
        x(:,i+1) = x(:,i) + h*(b(1)*k1 + b(2)*k2 + b(3)*k3 + b(4)*k4);
    end
    
end