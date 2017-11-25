function [ Function ] = GenerateSquarePulse( Amplitude, StartTime, EndTime )
%GenerateSquarePusle creates a square pulse
%   INPUT
%       Amplitude is the amplitude of the pulse
%       StartTime is the time when the pulse starts
%       EndTime is the time when the pulse stops
%   OUTPUT
%       Function is the function handle for the response
    %%
    % Setup step function
    u = @(t) t >= 0;
    %%
    % Generate ramp pulse
    Function = @(t) Amplitude .* (u(t - StartTime) - u(t - EndTime));
end

