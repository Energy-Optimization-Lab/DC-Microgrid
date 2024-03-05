% Load the hourly energy consumption data from the Excel file
energy_data = readtable('hourly_energy_consumption.xlsx');
hourly_energy_consumption = energy_data.HourlyEnergyConsumption_kWh;

temp_expanded = zeros(1, 720);  % Initialize the expanded array with zeros

for i = 1:length(hourly_energy_consumption)
    for j = 1:10
        temp_expanded((i-1)*10 + j) = hourly_energy_consumption(i);
    end
end

scaled_energy_consumption = temp_expanded * 10;

powerWatts = scaled_energy_consumption * 1000 / 1;

% Set the system voltage (e.g., for a 48V system)
system_voltage = 41;

% Calculate the resistance required for each hour to consume the specified power
resistance_values = (system_voltage^2) ./ powerWatts;

% Create a time vector corresponding to each data point
time = (0:length(resistance_values)-1)';

% Create a timeseries object for the resistance values
resistance_ts = timeseries(resistance_values, time);

% Create a Simulink.SimulationData.Dataset object for the scenario
scenario = Simulink.SimulationData.Dataset;
scenario = scenario.addElement(resistance_ts, 'Resistance');

% Save the scenario to a MAT file that can be loaded into the Signal Editor block
save('load_signal.mat', 'scenario');
