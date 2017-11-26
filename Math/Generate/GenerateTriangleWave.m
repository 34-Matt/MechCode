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
    % Create saw wave
    Saw = GenerateSawWave(2 * Amplitude, Type, Value);
    %%
    % Convert saw wave to triangle wave
    Function = @(t) abs(Saw(t)) - Amplitude;
end