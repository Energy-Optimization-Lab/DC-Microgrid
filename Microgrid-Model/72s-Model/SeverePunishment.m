function punishmentAllocation = SeverePunishment(BatteryAllocScore)
    % A function to find the punishment level of a load when the pool is at
    % a severely low level

    % intialize size of the punishmentAllocation array
    punishmentAllocation = zeros(1,length(BatteryAllocScore));

    for i=1:length(BatteryAllocScore)
        % assigns highest punishments to all loads
        punishmentAllocation(1,i) = 2;
    end

end
