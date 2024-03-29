function score = BatteryAllocScore(batterySoC, minBatteryPercentageRequired, ...
    BatteryPercentageToPool)
    % A function to calculate an individual load's score

    % Buffer is the excess amount of charge left in an individual's battery
    Buffer = batterySoC - minBatteryPercentageRequired - BatteryPercentageToPool;

    score = (BatteryPercentageToPool - Buffer)...
        /(batterySoC-minBatteryPercentageRequired) * 100;
end