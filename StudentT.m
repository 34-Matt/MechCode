function [ average,standardDeviation,degreeFreedom ] = StudentT( intArray )
    
    %Get degree of freedom based on sample size
    [~,length] = size(intArray);
    degreeFreedom = length - 1;
    
    %Average of all elements in array
    average = mean(intArray);
    
    %Standard deviation of array
    errorArray = intArray - average;
    errorSquareArray = errorArray.^2;
    errorSquare = sum(errorSquareArray);
    standardDeviation = sqrt(sum(errorSquare)/degreeFreedom);

end

