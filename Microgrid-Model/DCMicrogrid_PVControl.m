% Define time array
time = 0:0.1:100; % 0 to 100 seconds, with 0.1-second intervals

% Convert time to hours (0 to 24 hours)
time_hours = (time / 100) * 24;

% Define irradiance array
irradiance = zeros(size(time));
for i = 1:length(time)
    if time_hours(i) >= 6 && time_hours(i) < 18  % Daytime from 6 AM to 8 PM
        if time_hours(i) <= 15  % Before 3 PM
            % Adjusted slope for a lower rise to peak irradiance
            irradiance(i) = 1000 * (1 - cos(pi * (time_hours(i) - 6) / 9)) / 2;
        else  % After 3 PM
            % Steeper drop-off after peak irradiance
            irradiance(i) = 1000 * (1 + cos(pi * (time_hours(i) - 15) / 3)) / 2;
        end
    end
end


% Define temperature array
% Adjusting the phase to make the peak around the 60-second mark
temperature = 14.4444 + (25.5556 - 14.4444) * sin(2 * pi * (time / 100) - (2 * pi * 30 / 100));

% Create timeseries objects
ts_irradiance = timeseries(irradiance, time);
ts_temperature = timeseries(temperature, time);

% Create a Simulink.SimulationData.Dataset object
dataset = Simulink.SimulationData.Dataset();
dataset = dataset.addElement(ts_irradiance, 'Irradiance');
dataset = dataset.addElement(ts_temperature, 'Temperature');

% Save the dataset to a .mat file
save('pv_signals.mat', 'dataset');
