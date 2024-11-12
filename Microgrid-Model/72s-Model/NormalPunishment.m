function punishmentAllocation = NormalPunishment(BatteryAllocScore)
    % A function to find the punishment level of a load when the pool is at
    % a stable level

    % intialize size of the punishmentAllocation array
    punishmentAllocation = zeros(1,length(BatteryAllocScore));

    % Finding the average of all BatteryAllocation Scores
    AvgBatteryAllocScore = mean(BatteryAllocScore);
    
    % Calculating 4 Standard Deviations away from zero
    fourStdevs = -4*std(AvgBatteryAllocScore);

    % Calculating 2 standard Deviations away from the average
    twoStdevs = -2*std(AvgBatteryAllocScore);

    for i=1:length(BatteryAllocScore)
        if BatteryAllocScore(1,i) > fourStdevs
            % assigns highest punishment to loads > 4 stdevs away from mean
            punishmentAllocation(1,i) = 2;
        elseif BatteryAllocScore(1,i) > twoStdevs
            % assigns medium punishment to loads in between 2 and 4 stdevs
            % from mean
            punishmentAllocation(1,i) = 1;
        else
            % assigns no punishment to all other loads
            punishmentAllocation(1,i) = 0;
        end
    end

end
