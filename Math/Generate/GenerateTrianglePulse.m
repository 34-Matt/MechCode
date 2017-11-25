function [ Function ] = GenerateTrianglePulse( Amplitude, StartTime, EndTime )
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
    % Create two ramp functions
    MidTime = (StartTime + EndTime) / 2;
    Ramp1 = GenerateRampPulse(Amplitude, StartTime, MidTime);
    Ramp2 = GenerateRampPulse(-Amplitude, MidTime, EndTime);
    %%
    % Generate triangle pulse
    Function = @(t) Ramp1(t) + Ramp2(t) + Amplitude .* (u(t-MidTime) - u(t-EndTime));
end

