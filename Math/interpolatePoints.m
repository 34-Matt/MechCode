function [ y1 ] = interpolatePoints( x1, x0, x2, y0, y2 )
%interpolatePoints This function interpolates y(x1) between y0 and y2
%   INPUT:
%       x0 and x2 are the two given values on the chart
%       x1 is the value between x0 and x2 correlating to desired y1
%       y0 and y2 are given values correlating to x0 and x2 respectively
%   OUTPUT:
%       y1 the value you wish to interpolate
    %%
    % Use interpolation method 
    change = (x1-x0)/(x2-x1);
    y1 = y0 + change*(y2-y0);
end

