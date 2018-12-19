function [Tp_ss,Ts_ss,Tp,Ts,times] = finitePipeHeatFlow(pipe,fluid,amb,points,k,dk,ddk,tspan,T0)
    delta_x = pipe.L_x / points;
    ss_wrap = @(T) steadyState(T,pipe,fluid,amb,points,delta_x,k,dk,ddk);
    F_wrap = @(t,T) calc_F(T,pipe,fluid,amb,points,delta_x,k,dk);
    J_wrap = @(t,T) createJacobian(T,pipe,fluid,points,delta_x,k,dk,ddk);
    
    options_solve = optimoptions('fsolve','display','iter', ...
        'SpecifyObjectiveGradient',false,'MaxFunEvals',3000, ...
        'MaxIter',1000,'TolFun',1e-15,'StepTolerance',1e-16);
    options_ode = odeset('RelTol',1e-4,'AbsTol',1e-5,'Mass',MassMatrix(points,pipe,fluid), ...
        'MStateDependence','none','MassSingular','yes','Jacobian',J_wrap);
    
    T_ss = fsolve(ss_wrap,T0,options_solve);
    Tp_ss = T_ss(1:points);
    Ts_ss = T_ss(points+1:2*points);
    
    [times,T] = ode23t(F_wrap,tspan,T0,options_ode);
    T = T';
    Tp = T(1:points,:);
    Ts = T(points+1:2*points,:);
    
end

function [F,J] = steadyState(T,pipe,fluid,amb,points,delta_x,k,dk,ddk)
    F = calc_F(T,pipe,fluid,amb,points,delta_x,k,dk);
    J = createJacobian(T,pipe,fluid,points,delta_x,k,dk,ddk);
end

function F = calc_F(T,pipe,fluid,amb,points,delta_x,k,dk)
    Fp = zeros(points,1);
    Fs = Fp;
    Tp = T(1:points);
    Ts = T(points+1:2*points);
    
     %%Boundary Conditions:
    % x = 0
    Fp(1) = 100*(Tp(1) - pipe.T_0);
    Fs(1) = 100*(Ts(1) - fluid.T_0);
    % x = L_x
    Fp(points) = 100*(Tp(points) - Ts(points));
    Fs(points) = -fluid.mdot*fluid.c_p*(Ts(points)-Ts(points-1))/delta_x+...
        pi*pipe.d_int*pipe.h_Tint*(Tp(points)-Ts(points));
    
    %%Internal Conditions:
    for count = 2:points-1
        dTp = (Tp(count) - Tp(count-1))/delta_x;
        d2Tp = (Tp(count+1) - 2*Tp(count) + Tp(count-1))/delta_x^2;
        dTs = (Ts(count) - Ts(count-1))/delta_x;
        
        Fp(count) = pipe.A_c*(dk(Tp(count))*dTp^2 + k(Tp(count))*d2Tp) +...
            pi*pipe.d_ext*(amb.q_solar-pipe.eps*pipe.sigma_B*(Tp(count)^4-amb.T^4)) - ...
            pi*pipe.d_int*pipe.h_Tint*(Tp(count)-Ts(count));
        Fs(count) = -fluid.mdot*fluid.c_p*dTs + ...
            pi*pipe.d_int*pipe.h_Tint*(Tp(count)-Ts(count));
    end
    F = [Fp;Fs];
end

function J = createJacobian(T,pipe,fluid,points,delta_x,k,dk,ddk)
    Tp = T(1:points);
    
    %%Boundary Conditions:
    % x = 0
    J = sparse([1,points+1],[1,points+1],100,2*points,2*points);
    
    %%Internal Conditions:
    for count = 2:points
        % Fp
        if count == points
            % Boundary: x = L_x
            J = J+sparse(points,points,100,2*points,2*points);
            J = J+sparse(points,2*points,-100,2*points,2*points);
        else
            J=J+sparse(count,count-1, ...
                (pipe.A_c/delta_x^2)*(-2*dk(Tp(count))*(Tp(count)-Tp(count-1))+k(Tp(count))), ...
                2*points,2*points);
            J=J+sparse(count,count, ...
                pipe.A_c*(ddk(Tp(count))*((Tp(count)-Tp(count-1))/delta_x)^2 + ...
                (2*dk(Tp(count))/delta_x)*((Tp(count)-Tp(count-1))/delta_x) + ...
                dk(Tp(count))*((Tp(count+1)-2*Tp(count)+Tp(count-1))/delta_x^2) - ...
                2*k(Tp(count))/delta_x^2) - ...
                4*pi*pipe.d_ext*pipe.eps*pipe.sigma_B*Tp(count)^3 - ...
                pi*pipe.d_int*pipe.h_Tint, 2*points, 2*points);
            J=J+sparse(count,count+1, ...
                pipe.A_c * k(Tp(count))/delta_x^2, 2*points, 2*points);
            J=J+sparse(count,count+points, ...
                pi*pipe.d_int*pipe.h_Tint, 2*points, 2*points);
        end
        
        % Fs
        J=J+sparse(count+points,count,pi*pipe.d_int*pipe.h_Tint,...
            2*points,2*points);
        J=J+sparse(count+points,count+points-1, ...
            fluid.mdot*fluid.c_p / delta_x, 2*points,2*points);
        J=J+sparse(count+points,count+points, ...
            -(fluid.mdot*fluid.c_p/delta_x) - pi*pipe.d_int*pipe.h_Tint, ...
            2*points,2*points);
    end
end

function matrix = MassMatrix(points,pipe,fluid)
    matrix = sparse(2:points-1,2:points-1,pipe.A_c*pipe.rho*pipe.c_p,...
        2*points,2*points);
    matrix = matrix+sparse(points+1:2*points,points+1:2*points,...
        pi*pipe.d_int^2*fluid.rho*fluid.c_p/4,2*points,2*points);
end