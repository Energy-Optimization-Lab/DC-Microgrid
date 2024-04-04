function createFunctions(numScores)
    % Open a new file for writing CombineData function
    fid1 = fopen('CombineData.m', 'w');
    
    % Write the function signature for CombineData with a variable number of inputs
    fprintf(fid1, 'function combinedData = CombineData(');
    for i = 1:numScores
        fprintf(fid1, 'BatteryAllocScore%d', i);
        if i < numScores
            fprintf(fid1, ', ');
        end
    end
    fprintf(fid1, ')\n\n');
    
    % Write the body of the CombineData function to combine the scores into a single array
    fprintf(fid1, '    combinedData = [');
    for i = 1:numScores
        fprintf(fid1, 'BatteryAllocScore%d', i);
        if i < numScores
            fprintf(fid1, ', ');
        end
    end
    fprintf(fid1, '];\n\n');
    
    % End the CombineData function
    fprintf(fid1, 'end\n');
    
    % Close the file for CombineData
    fclose(fid1);
    
    % Open a new file for writing DemuxPunishments function
    fid2 = fopen('DemuxPunishments.m', 'w');
    
    % Write the function signature for DemuxPunishments with a variable number of outputs
    fprintf(fid2, 'function [');
    for i = 1:numScores
        fprintf(fid2, 'PunishmentScore%d', i);
        if i < numScores
            fprintf(fid2, ', ');
        end
    end
    fprintf(fid2, '] = DemuxPunishments(input)\n\n');
    
    % Write the body of the DemuxPunishments function to extract individual scores from the input array
    for i = 1:numScores
        fprintf(fid2, '    PunishmentScore%d = input(%d);\n', i, i);
    end
    
    % End the DemuxPunishments function
    fprintf(fid2, '\nend\n');
    
    % Close the file for DemuxPunishments
    fclose(fid2);
end
