function [TM,YZ] = GraphResponse( m, c, k, Force, time, interval, startPos, startVel, solver, h )
%GraphResponse This function creates three charts of the force
%displacement, and velocity of a vibrating object
%   INPUT:
%       m, c, and k are the mass, damping, and spring coefficents of the
%       sytem.
%       Force is the force responce acting on the system.  This can be a
%       number or a function_handle
%       time is the time after 0 that you want the graph to be running for
%       interval is the number of points between 0 and time
%       startPos is the initial displacement of the system at time 0
%       startVel is the initial velocity of the system at time 0
%       solver is the name of solver function (void to use ode45) (must be
%           a function handle
%       h is the step size of the solver
    %%
    % Setup repsonse equation
    t = linspace(0,time,interval);
    if ~sameSize(m, c, k, Force, startPos, startVel)
        error("Sizes of matrices do not match")
    elseif(isa(Force, 'function_handle'))
        [row,~] = size(startPos);
        for count = 1:length(t)
            y(:,count) = Force(count);
        end
        F = @(t,y) [y(row+1:2*row);m\(Force(t) - c * y(row+1:2*row) - k * y(1:row))];
    elseif(isa(Force, 'double'))
        [row,~] = size(startPos);
        y(:,1:interval) = Force;
        F = @(t,y) [y(row+1:2*row);m\(Force - c * y(row+1:2*row) - k * y(1:row))];
    else
        error("Unknown type " + class(Force))
    end
    %%
    % Display forcing function
    figure(1);
    hold on
    for count = 1:row
        plot(t,y(count,:),'LineWidth',2.0)
    end
    plot(t,y,'LineWidth',2.0)
    xlabel('time, secs')
    ylabel('F(t)')
    title('THE GIVEN FORCING FUNCTION')
    hold off
    %%
    % Setup time span and differential
    tspan = [0, time];
    yinit = [startPos;startVel];
    if exist('solver','var')
        [YZ,TM] = solver(F,0,time,h,yinit);
        YZ = YZ';
        TM = TM';
    else
        [TM,YZ] = ode45(F,tspan,yinit);
    end
    %%
    % Display displacement function
    figure(2);
    hold on
    for count = 1:row
        plot(TM,YZ(:,count),'LineWidth',2.0)
    end
    xlabel('time, secs')
    ylabel('Displacement')
    title('Displacement Profile')
    hold off
    %%
    % Display velocity function
    figure(3);
    hold on
    plot(TM,YZ(:,row+1:2*row),'LineWidth',2.0);
    xlabel('time, secs')
    ylabel('Velocity')
    title('Velocity Profile')
    hold off
end
function bool = sameSize(m, c, k, Force, startPos, startVel)
    % Checks if the dimensions are correct
    bool = isequal(size(m),size(c),size(k));
    if ~bool
        return
    end
    bool = isequal(size(Force(1)),size(startPos),size(startVel));
    if ~bool
        return
    end
    [row1,col1] = size(m);
    [row2,col2] = size(Force(1));
    bool = isequal(col1,row1) && isequal(row1,row2) && isequal(col2,1);
end