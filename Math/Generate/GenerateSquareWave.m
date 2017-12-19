function [ Function ] = GenerateSquareWave( Amplitude, Type, Value )
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
    % Find angular frequency
    Type = upper(Type);
    if (strcmp(Type,"ANGULAR") || strcmp(Type,"ANGULAR FREQUENCY"))
        w = Value;
    elseif (strcmp(Type,"FREQUENCY"))
        w = 2 * pi * Value;
    elseif (strcmp(Type,"PERIOD") || strcmp(Type,"WAVELENGTH"))
        w = 2 * pi * (1 / Value);
    else
        error("Unknown type: %s",Type);
        return
    end
    %%
    % Generate ramp pulse
    Function = @(t) Amplitude .* (u(sin(w .* t)) - u(-sin(w .* t)));
end

