function val = Ackermann(m,n)
% This is an example of a total computable function that is not primitive
% recursive.
%

    % Inputs must be positive integers
    if m<0 && img(m)~=0
        warning('m should be a real positive integer in order to collapse')
        m = real(round(abs(m)));
    elseif rem(m,1)~=0
        warning('m should be a real positive integer in order to collapse')
        m = real(round(abs(m)));
    end
    
    if n<0 && img(n)~=0
        warning('m should be a real positive integer in order to collapse')
        n = real(round(abs(n)));
    elseif rem(n,1)~=0
        warning('m should be a real positive integer in order to collapse')
        n = real(round(abs(n)));
    end
    
    % Ackermann
    if m ==0
        val = n + 1;
    elseif m > 0 && n == 0
        val = Ackermann(m-1,1);
    elseif m >0 && n > 0
        val = Ackermann(m-1,Ackermann(m,n-1));
    else
        fprintf('Something went wrong with values %f and %f',m,n);
    end
    
end