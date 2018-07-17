function [x,t,h] = Butcher(f,ti,tf,h0,x0,tol)
    
    c = [0;1/2;3/4;1];
    a = [0 0 0 0
        1/2 0 0 0
        0 3/4 0 0
        2/9 1/3 4/9 0];
    b1 = [2/9 1/3 4/9 0];
    b2 = [7/24 1/4 1/3 1/8];
    
    if ischar(f)
        f = str2func(f);
    end
    
    t(1) = ti;
    count = 0;
    x(:,1) = x0;
    h(1) =h0;
    if ~exist('tol','var')
        tol = 1E-8;
    end
    
    while t < tf
        count = count + 1;
        k1 = f(t(count),x(:,count));
        k2 = f(t(count)+c(2)*h(count),x(:,count)+h(count)*a(2,1)*k1);
        k3 = f(t(count)+c(3)*h(count),x(:,count)+h(count)*(a(3,1)*k1 + a(3,2)*k2));
        k4 = f(t(count)+c(4)*h(count),x(:,count)+h(count)*(a(4,1)*k1 + a(4,2)*k2 + a(4,3)*k3));
        x1 = x(:,count) + h(count)*(b1(1)*k1 + b1(2)*k2 + b1(3)*k3 + b1(4)*k4);
        x2 = x(:,count) + h(count)*(b2(1)*k1 + b2(2)*k2 + b2(3)*k3 + b2(4)*k4);
        
        t(count+1) = t(count) + h(count);
        maxVal = max(tol./abs(x1-x2),0.3);
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
        x1 = x(:,count) + h(count)*(b1(1)*k1 + b1(2)*k2 + b1(3)*k3 + b1(4)*k4);
        
        t(count+1) = t(count) + htemp;
        x(:,count+1) = x1;
    end
    
end