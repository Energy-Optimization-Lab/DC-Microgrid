function combinedData = CombineData(BatteryAllocScore1, BatteryAllocScore2, BatteryAllocScore3, BatteryAllocScore4, BatteryAllocScore5)
    BatteryAllocScore1 = BatteryAllocScore1(1:10);
    BatteryAllocScore2 = BatteryAllocScore2(1:10);
    BatteryAllocScore3 = BatteryAllocScore3(1:10);
    BatteryAllocScore4 = BatteryAllocScore4(1:10);
    BatteryAllocScore5 = BatteryAllocScore5(1:10);

    combinedData = [BatteryAllocScore1;BatteryAllocScore2;BatteryAllocScore3;BatteryAllocScore4;BatteryAllocScore5];
end