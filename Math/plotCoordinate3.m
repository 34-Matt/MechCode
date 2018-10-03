function fig = plotCoordinate3(R,d,name,fig)
%PLOTCOORDINATE3 Creates a 3D coordinate at d with rotation R
    % Creates a new figure if parent class is not passed in
    if ~exist('fig','var')
        fig = figure();
    end
    figure(fig);
    hold on
    
    % Break inputs into workable components
    % x,y,and z are the location of the new origin
    x = d(1);
    y = d(2);
    z = d(3);
    
    % da_b is the change in a for unit vector b
    dx_x = R(1,1);
    dy_x = R(2,1);
    dz_x = R(3,1);
    
    dx_y = R(1,2);
    dy_y = R(2,2);
    dz_y = R(3,2);
    
    dx_z = R(1,3);
    dy_z = R(2,3);
    dz_z = R(3,3);
    
    % Create plots
    plot3([x,x+dx_x],[y,y+dy_x],[z,z+dz_x],'-k','LineWidth',0.5);
    plot3([x,x+dx_y],[y,y+dy_y],[z,z+dz_y],'-k','LineWidth',0.5);
    plot3([x,x+dx_z],[y,y+dy_z],[z,z+dz_z],'-k','LineWidth',0.5);
    text(x,y,z,name)
    hold off
end

