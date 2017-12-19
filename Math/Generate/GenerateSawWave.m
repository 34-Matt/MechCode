function [ Function ] = GenerateSawWave ( Amplitude, Type, Value )
%GenerateSquarePusle creates a square pulse
%   INPUT
%       Amplitude is the amplitude of the pulse
%       Type is the means for defining the wavelength.  Valid options of
%       "Angular", "Angular Frequency", "Frequency", "Period", or
%       "Wavelength"
%       Value that is dependant on Type
%   OUTPUT
%       Function is the function handle for the response
    %%
    % Setup step function
    u = @(t) t >= 0;
    %%
    % Find period
    Type = upper(Type);
    if (strcmp(Type,"ANGULAR") || strcmp(Type,"ANGULAR FREQUENCY"))
        period = (2 * pi) / Value;
    elseif (strcmp(Type,"FREQUENCY"))
        period = 1 / Value;
    elseif (strcmp(Type,"PERIOD") || strcmp(Type,"WAVELENGTH"))
        period = Value;
    else
        error("Unknown type: %s",Type);
        return
    end
    %%
    % Generate ramp pulse
    Function = @(t) Amplitude .* (2 .* (t ./ period) - 1 - 2 .* fix(t ./ period));
end