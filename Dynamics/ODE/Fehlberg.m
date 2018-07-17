function [x,t,h] = Fehlberg(f,ti,tf,h0,x0,tol)
    
    c = [0;1/4;3/8;12/13;1;1/2];
    a = [0 0 0 0 0 0
        1/4 0 0 0 0 0
        3/32 9/32 0 0 0 0
        1932/2197 -7200/2197 7296/2197 0 0 0
        439/216 -8 3680/513 -845/4104 0 0
        -8/27 2 -3544/2565 1859/4101 -11/40 0];
    b1 = [16/135 0 6656/12825 28561/56430 -9/50 2/55];
    b2 = [25/216 0 1408/2565 2197/4104 -1/5 0];
    
    if ischar(f)
        f = str2func(f);
    end
    
    t(1) = ti;
    count = 0;
    x(:,1) = x0;
    h(1) = h0;
    if ~exist('tol','var')
        tol = 1E-8;
    end
    
    while t < tf
        count = count + 1;
        k1 = f(t(count),x(:,count));
        k2 = f(t(count)+c(2)*h(count),x(:,count)+h(count)*a(2,1)*k1);
        k3 = f(t(count)+c(3)*h(count),x(:,count)+h(count)*(a(3,1)*k1 + a(3,2)*k2));
        k4 = f(t(count)+c(4)*h(count),x(:,count)+h(count)*(a(4,1)*k1 + a(4,2)*k2 + a(4,3)*k3));
        k5 = f(t(count)+c(5)*h(count),x(:,count)+h(count)*(a(5,1)*k1 + a(5,2)*k2 + a(5,3)*k3 + a(5,4)*k4));
        k6 = f(t(count)+c(6)*h(count),x(:,count)+h(count)*(a(6,1)*k1 + a(6,2)*k2 + a(6,3)*k3 + a(6,4)*k4 + a(6,5)*k5));
        x1 = x(:,count) + h(count)*(b1(1)*k1 + b1(2)*k2 + b1(3)*k3 + b1(4)*k4 + b1(5)*k5 + b1(6)*k6);
        x2 = x(:,count) + h(count)*(b2(1)*k1 + b2(2)*k2 + b2(3)*k3 + b2(4)*k4 + b2(5)*k5 + b2(6)*k6);
        
        t(count+1) = t(count) + h(count);
        maxVal = norm(max(tol./abs(x1-x2),0.3));
        minVal = min(maxVal,2);
        h(count+1) = 0.9*h(count)*minVal; %Correction factor
        x(:,count+1) = x1;
    end
    if t(count+1) ~= tf
        htemp = tf-t(count);
        k1 = f(t(count),x(:,count));
        k2 = f(t(count)+c(2)*h(count),x(:,count)+h(count)*a(2,1)*k1);
        k3 = f(t(count)+c(3)*h(count),x(:,count)+h(count)*(a(3,1)*k1 + a(3,2)*k2));
        k4 = f(t(count)+c(4)*h(count),x(:,count)+h(count)*(a(4,1)*k1 + a(4,2)*k2 + a(4,3)*k3));
        k5 = f(t(count)+c(5)*h(count),x(:,count)+h(count)*(a(5,1)*k1 + a(5,2)*k2 + a(5,3)*k3 + a(5,4)*k4));
        k6 = f(t(count)+c(6)*h(count),x(:,count)+h(count)*(a(6,1)*k1 + a(6,2)*k2 + a(6,3)*k3 + a(6,4)*k4 + a(6,5)*k5));
        x1 = x(:,count) + h(count)*(b1(1)*k1 + b1(2)*k2 + b1(3)*k3 + b1(4)*k4 + b1(5)*k5 + b1(6)*k6);
        
        t(count+1) = t(count) + htemp;
        x(:,count+1) = x1;
    end
    
end