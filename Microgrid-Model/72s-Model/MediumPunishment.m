function punishmentAllocation = MediumPunishment(BatteryAllocScore)
    % A function to find the punishment level of a load when the pool is
    % somewhat depleted

    % intialize size of the punishmentAllocation array
    punishmentAllocation = zeros(1,length(BatteryAllocScore));

    % Finding the average of all BatteryAllocation Scores
    AvgBatteryAllocScore = mean(BatteryAllocScore);
    
    % Calculating 4 Standard Deviations away from the average
    fourStdevs = -4*std(AvgBatteryAllocScore); % Should this be BatteryAllocScore (i.e elements rather than the mean)

    for i=1:length(BatteryAllocScore)
        if BatteryAllocScore(1,i) > fourStdevs
            % assigns highest punishment to loads > 4 stdevs away from mean
            punishmentAllocation(1,i) = 2;
        else
            % assigns medium punishment to all other loads
            punishmentAllocation(1,i) = 1;
        end
    end
end
