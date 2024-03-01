% Load the hourly energy consumption data from the Excel file
energy_data = readtable('hourly_energy_consumption.xlsx');
hourly_energy_consumption = energy_data.HourlyEnergyConsumption_kWh;

% Scale the data for 10 houses
scaled_energy_consumption = hourly_energy_consumption * 10;

% Convert energy consumption (kWh) to power (kW) for each hour
hourly_power = scaled_energy_consumption; % 1 kWh over 1 hour is 1 kW

% Set the system voltage (e.g., for a 48V system)
system_voltage = 48;

% Calculate the resistance required for each hour to consume the specified power
resistance_values = (system_voltage^2) ./ hourly_power;

% Create a time vector corresponding to each hour
time_hours = (0:length(resistance_values)-1)';

% Create a timeseries object for the resistance values
resistance_ts = timeseries(resistance_values, time_hours);

% Create a Simulink.SimulationData.Dataset object for the scenario
scenario = Simulink.SimulationData.Dataset;
scenario = scenario.addElement(resistance_ts, 'Resistance');

% Save the scenario to a MAT file that can be loaded into the Signal Editor block
save('load_signal.mat', 'scenario');
