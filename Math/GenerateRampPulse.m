function [ Function ] = GenerateRampPulse( Amplitude, StartTime, EndTime )
%GenerateSquarePusle creates a square pulse
%   INPUT
%       Amplitude is the amplitude of the pulse
%       StartTime is the time when the pulse starts
%       EndTime is the time when the pulse stops
%   OUTPUT
%       Function is the function handle for the response
    
    u = @(t) t >= 0;
    Function = @(t) Amplitude .* ((t - StartTime) ./ (EndTime - StartTime)) .* (u(t - StartTime) - u(t - EndTime));

end
