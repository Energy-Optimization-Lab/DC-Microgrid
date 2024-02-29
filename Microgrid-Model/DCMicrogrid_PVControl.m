% Load the Excel file for temperature data
temperatureData = readtable('testDataTempSolar.xlsx');

% Extract temperature data and assume hourly measurements
temp = temperatureData.T2M; 

% Smooth the temperature data using a moving average filter
windowSize = 10; % Adjust the window size as needed
smoothedTemp = movingAverage(temp, windowSize);

% Initialize irradiance array
irradiance = zeros(1, 72);

% Day 1: Sunny
for i = 1:24
    irradiance(i) = simulateIrradiance(i, 1);
end

% Day 2: Randomly cloudy (up to 20% of the daytime)
for i = 25:48
    if rand() <= 0.2  % 20% chance for cloud coverage at any given hour
        irradiance(i) = simulateIrradiance(i - 24, 2) * 0.3; % 70% reduction due to cloud coverage
    else
        irradiance(i) = simulateIrradiance(i - 24, 2);
    end
end

% Day 3: Overcast and raining
for i = 49:72
    irradiance(i) = simulateIrradiance(i - 48, 3) * 0.1; % 90% reduction due to overcast and rain
end

% Create a Simulink.SimulationData.Dataset object
scenario = Simulink.SimulationData.Dataset;

% Add data for smoothed temperature and raw irradiance without time information
scenario = scenario.addElement(timeseries(irradiance'), 'Irradiance');
scenario = scenario.addElement(timeseries(smoothedTemp'), 'SmoothedTemperature');

% Save the scenario to a .mat file
save('pv_signals.mat', 'scenario');

% Function for moving average
function smoothedData = movingAverage(data, windowSize)
    b = (1/windowSize)*ones(1, windowSize);
    a = 1;
    smoothedData = filter(b, a, data);
end

% Function for irradiance simulation
function irrad = simulateIrradiance(hour, day)
    if hour >= 6 && hour < 18
        if day == 1  % Sunny day
            irrad = 1000 * (1 - cos(pi * (hour - 6) / 6)) / 2;
        elseif day == 2  % Randomly cloudy
            irrad = 800 * (1 - cos(pi * (hour - 6) / 6)) / 2;  % Slightly lower peak
        else  % Overcast and raining
            irrad = 600 * (1 - cos(pi * (hour - 6) / 6)) / 2;  % Even lower peak
        end
    else
        irrad = 0;
    end
end

