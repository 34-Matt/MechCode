function varargout = ODESolver_Linear_Homogenous_ConstCo(polynomial,x0,t)
%% Finds solution in the form ax" + bx' + cx = 0
% INPUT:
%   polynomial is a vector containing [a,b,c]
%   x0 is the initial conditions
%   t is the time span (optional)
% OUTPUT:
%   if t exist
%       the values of x(t) and x'(t)
%   else
%       C is the coefficients of the general solution
%       r is the roots of the general solutions
    % It is assumed that the solution is in the form x = e^rt
    % Equation becomes e^rt * (ar^2 + br + c) = 0
    % Solution becomes ar^2 + br + c = 0
    r = roots(polynomial);
    
    if r(1) == r(2)
        % The general solution is x = C_1 * e^r1*t + C_2 * t * e^r2*t
        % Solve for C_1 and C_2 using the initial conditions
        % x_0 = C_1
        % x_0' = C_1 * r_1 + C_2 = x_0 * r_1 + C_2
        % C_2 = x_0' - x_0 * r_1
        C = [x0(1);x0(2) - x0(1)*r(1)];
        
        % Determine if output should be equation or values
        if exist('t','var')
            OutputArg(1,:) = C(1) * exp(r(1)*t) + C(2) * t * exp(r(2)*t);
            OutputArg(2,:) = C(1)*r(1)*exp(r(1)*t) + ...
                C(2)*exp(r(2)*t) + C(2)*t*r(2)*exp(r(2)*t);
            varargout{1} = OutputArg;
        else
            varargout{1} = C;
            varargout{2} = r;
        end
        
    else
        % The general solution is x = C_1 * e^r_1*t + C_2 * e^r_2*t
        % Solve for C_1 and C_2 using the initial conditions
        % x_0 = C_1 + C_2
        % x_0' = C_1 * r_1 + C_2 * r_2
        M = [1 1
            r(1) r(2)];
        C = M\x0;
    
        % Determine if output should be equation or values
        if exist('t','var')
            OutputArg(1,:) = C(1) * exp(r(1)*t) + C(2) * exp(r(2)*t);
            OutputArg(2,:) = C(1) * r(1) * exp(r(1)*t) + ...
                C(2) * r(2) * exp(r(2)*t);
            varargout{1} = OutputArg;
        else
            varargout{1} = C;
            varargout{2} = r;
        end
    end

end