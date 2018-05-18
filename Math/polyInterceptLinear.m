function [ x,y ] = polyInterceptLinear( p1,p2 )
%polyInterceptLinear This function takes two polyvalue values and finds the
%intercept of the two line
%   INPUT:
%       p1 and p2 are returns from the polyfit function and are linear
%   OUTPUT:
%       x is the point where the lines intercept
%       y is the values where the lines intercept
    %%
    % Find point of interct
    m = p1(1) - p2(1);
    inter = p2(2) - p1(2);
    x = inter/m;
    %%
    % Find value at x
    y = polyval(p1,x);
end

