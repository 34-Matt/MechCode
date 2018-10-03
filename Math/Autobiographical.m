function biograph = Autobiographical(n)
%Generates an autobiographical number of size n
%
% An auotbiographical number is an array of size n where the sum of each
% element equals n and the ith describes how many instances of (i-1) are in
% the array
    n = round(n);
    if n <= 3 || n == 6
        warning('No autobiographical numbers exist for number %d',n)
        biograph = 0;
        return
    elseif n > 13
        warning('Solution is not ideal for base 10')
    elseif n == 4
        biograph = [1 2 1 0];
        return
    elseif n == 5
        biograph = [2 1 2 0 0];
        return
    end
    
    biograph = zeros(1,n);
    num1 = n - 4;
    biograph(1) = num1;
    biograph(2) = 2;
    biograph(3) = 1;
    biograph(num1+1) = 1;
end

