% Define time array for three days (0 to 300 seconds, with 0.1-second intervals)
time = 0:0.1:300;

% Convert time to hours (0 to 72 hours)
time_hours = time / 3600;

% Define irradiance array for three days
irradiance = zeros(size(time));

% Day 1: Perfect condition
for i = 1:length(time)
    if time_hours(i) >= 6 && time_hours(i) < 18  % Daytime from 6 AM to 6 PM
        if time_hours(i) <= 15  % Before 3 PM
            % Adjusted slope for a lower rise to peak irradiance
            irradiance(i) = 1000 * (1 - cos(pi * (time_hours(i) - 6) / 9)) / 2;
        else  % After 3 PM
            % Steeper drop-off after peak irradiance
            irradiance(i) = 1000 * (1 + cos(pi * (time_hours(i) - 15) / 3)) / 2;
        end
    end
end

% Day 2: Random clouds for up to 20% of daytime
day2_start = find(time_hours >= 24, 1);
day2_end = find(time_hours < 48, 1, 'last');
daytime_indices = find(time_hours >= 30 & time_hours < 42);  % Daytime from 6 AM to 6 PM
cloudy_indices = randsample(daytime_indices, floor(length(daytime_indices) * 0.2));  % 20% cloudy

for i = day2_start:day2_end
    if ismember(i, cloudy_indices)
        irradiance(i) = irradiance(i) * 0.5;  % Reduce irradiance by 50% for clouds
    end
end

% Day 3: Storming/overcast the entire day
day3_start = find(time_hours >= 48, 1);
day3_end = find(time_hours <= 72, 1, 'last');

for i = day3_start:day3_end
    if time_hours(i) >= 54 && time_hours(i) < 66  % Daytime from 6 AM to 6 PM
        irradiance(i) = irradiance(i) * 0.2;  % Reduce irradiance by 80% for overcast
    end
end

% Define temperature array for three days
% Adjusting the phase to make the peak around the 150-second mark
temperature = 14.4444 + (25.5556 - 14.4444) * sin(2 * pi * (time / 300) - (2 * pi * 90 / 300));

% Create timeseries objects
ts_irradiance = timeseries(irradiance, time);
ts_temperature = timeseries(temperature, time);

% Create a Simulink.SimulationData.Dataset object
dataset = Simulink.SimulationData.Dataset();
dataset = dataset.addElement(ts_irradiance, 'Irradiance');
dataset = dataset.addElement(ts_temperature, 'Temperature');

% Save the dataset to a .mat file
save('pv_signals_3days.mat', 'dataset');
