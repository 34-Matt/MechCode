function [ average,standardDeviation,degreeFreedom ] = StudentT( intArray )
%StudentT This function determines mean, standard deviation, and degrees of
%freedom
%   INPUT:
%       intArray The array of data points from the measurand
%   OUTPUT:
%       average The mean of the sample
%       standardDeviation The standard deviation of the sample
%       degreeFreedom The degree of freedom of the sample
    %%
    % Get degree of freedom based on sample size
    count = length(intArray);
    degreeFreedom = count - 1;
    %%
    % Average of all elements in array
    average = mean(intArray);
    %%
    % Standard deviation of array
    errorArray = intArray - average;
    errorSquareArray = errorArray.^2;
    errorSquare = sum(errorSquareArray);
    standardDeviation = sqrt(sum(errorSquare)/degreeFreedom);
end

