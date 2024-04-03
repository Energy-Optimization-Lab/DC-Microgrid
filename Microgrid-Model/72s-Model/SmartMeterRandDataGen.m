% Generate arrays of 10 random values
BatterySoCRandom = randi([50,100], 10, 1);
minBatteryPercentageRequiredRandom = randi([10,25], 10, 1);
BatteryPercentageKept = rand([10, 1]) .* (BatterySoCRandom - minBatteryPercentageRequiredRandom);
BatteryPercentageToPoolRandom = max(0, BatterySoCRandom - minBatteryPercentageRequiredRandom - BatteryPercentageKept);

% Create timeseries objects for each element of the arrays
BatterySoCTimeseries = timeseries(BatterySoCRandom);
minBatteryPercentageRequiredTimeseries = timeseries(minBatteryPercentageRequiredRandom);
BatteryPercentageToPoolTimeseries = timeseries(BatteryPercentageToPoolRandom);

% Create a Simulink.SimulationData.Dataset object
Scenario = Simulink.SimulationData.Dataset;

% Add timeseries elements to the Dataset
Scenario = Scenario.addElement(BatterySoCTimeseries, 'BatterySoC');
Scenario = Scenario.addElement(minBatteryPercentageRequiredTimeseries, 'MinSoC');
Scenario = Scenario.addElement(BatteryPercentageToPoolTimeseries, 'BatteryPercentageToPool');

% Save the scenario to a .mat file
save('fauxData5.mat', 'Scenario');

