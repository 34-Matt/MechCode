function GraphResponse( m, c, k, Force, time, startPos, startVel )
%GraphResponse This function creates three charts of the force,
%displacement, and velocity of a vibrating object
%   INPUT:
%       m, c, and k are the mass, damping, and spring coefficents of the
%       sytem.
%       Force is the force responce acting on the system.  This can be a
%       number or a function_handle
%       time is the time after 0 that you want the graph to be running for.
%       startPos is the initial displacement of the system at time 0
%       startVel is the initial velocity of the system at time 0
%   OUTPUT:
%       fGraph is the graph of the forcing function
%       dGraph is the graph of the displacement
%       vGraph is the graph of the velocity

    t = linspace(0,time,1000);
    
    if(isa(Force, 'function_handle'))
        y = Force(t);
        F = @(t,y) [y(2);(Force(t) - c .* y(2) - k .* y(1)) ./ m];
    elseif(isa(Force, 'double'))
        y(1:1000) = Force;
        F = @(t,y) [y(2);(Force - c .* y(2) - k .* y(1)) ./ m];
    else
        disp("Unknown type " + class(Force))
    end
    
    figure(1);
    hold on
    plot(t,y,'k','LineWidth',2.0)
    xlabel('time, secs')
    ylabel('F(t)')
    title('THE GIVEN FORCING FUNCTION')
    hold off
    
    
    tspan = [0, time];
    yinit = [startPos;startVel];
    
    [TM,YZ] = ode45(F,tspan,yinit);
    
    figure(2);
    hold on
    plot(TM,YZ(:,1),'k','LineWidth',2.0)
    xlabel('time, secs')
    ylabel('Displacement')
    title('Displacement Profile')
    hold off
    
    figure(3);
    hold on
    plot(TM,YZ(:,2),'k','LineWidth',2.0);
    xlabel('time, secs')
    ylabel('Velocity')
    title('Velocity Profile')
    hold off
    
end
